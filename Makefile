# Makefile for LaTeX Resume/CV
.PHONY: help all job list clean clean-job job_error

help: 
	@echo "Available commands:"
	@echo "  job JOB=<job-name>      - Build specific job application"
	@echo "  create JOB=<job-name>   - create job from template"
	@echo "  all                     - Build all job applications"
	@echo "  list                    - List available job applications"
	@echo "  clean                   - Clean build directory"
	@echo "  clean JOB=<job>         - Clean specific job build"
	@echo "  remove JOB=<job>        - remove specific job build"
	@echo "  test                    - Test the Template" 

job:
ifndef JOB 
	@echo "Error: JOB variable not set"
	@echo "Usage: make job JOB=<job-name>"
	@echo "Available jobs:"
	@find jobs -maxdepth 1 -type d -not -path jobs | sed 's|jobs/|- |' | sort
	@exit 1
endif
	@./build_resume $(JOB) jobs

create:
ifndef JOB 
	@echo "Error: JOB variable not set"
	@echo "Usage: make create JOB=<job-name>"
	@exit 1
endif
	@echo "creating the job $(JOB)"
	@mkdir -p jobs/$(JOB) && cp -r src/template/* jobs/$(JOB)
	@echo "copied from template."

# Build all job applications
all:
	@echo "Building all job applications..."
	@for job in $$(find jobs -maxdepth 1 -type d -not -path jobs | sed 's|jobs/||'); do \
		echo "Building $$job..."; \
		./build_resume $$job jobs || exit 1; \
	done
	@echo "All jobs built successfully!"

list:
	@echo "Available job resume:"
	@find jobs -maxdepth 1 -type d -not -path jobs | sed 's|jobs/|- |' | sort

clean:
ifdef JOB 
	@echo "Cleaning build files for $(JOB)..."
	@rm -rf build/resume_$(JOB).pdf
	@echo "Build files for $(JOB) cleaned."
else
	@echo "Cleaning build directory..."
	@rm -rf build/*
	@echo "Build directory cleaned."
endif

remove:
ifndef JOB 
	@echo "Error: JOB variable not set"
	@echo "Usage: make create JOB=<job-name>"
	@exit 1
else
	@echo "Cleaning job directory..."
	@rm -rf jobs/$(JOB)
	@echo "Job directory cleaned."
endif

test:
	@./build_resume template src

