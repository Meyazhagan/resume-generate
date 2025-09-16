# Makefile for LaTeX Resume/CV

.PHONY: help clean job all list

help:
	@echo "Available targets:"
	@echo "  job JOB=<job-name>  - Build specific job application"
	@echo "  all                 - Build all job applications"
	@echo "  list                - List available job applications"
	@echo "  clean               - Clean build directory"
	@echo "  clean-job JOB=<job> - Clean specific job build"
	@echo ""
	@echo "Examples:"
	@echo "  make job JOB=software-engineer-abc"
	@echo "  make all"
	@echo "  make clean"

# Build specific job
job:
ifndef JOB
	@echo "Error: JOB variable not set"
	@echo "Usage: make job JOB=<job-name>"
	@echo "Available jobs:"
	@find jobs -maxdepth 1 -type d -not -path jobs | sed 's|jobs/||' | sort
	@exit 1
endif
	@./build.sh $(JOB)

# Build all job applications
all:
	@echo "Building all job applications..."
	@for job in $$(find jobs -maxdepth 1 -type d -not -path jobs | sed 's|jobs/||'); do \
		echo "Building $$job..."; \
		./build.sh $$job || exit 1; \
	done
	@echo "All jobs built successfully!"

# List available job applications
list:
	@echo "Available job applications:"
	@find jobs -maxdepth 1 -type d -not -path jobs | sed 's|jobs/|- |' | sort

# Clean all build files
clean:
	@echo "Cleaning build directory..."
	@rm -rf build/*
	@echo "Build directory cleaned."

# Clean specific job build
clean-job:
ifndef JOB
	@echo "Error: JOB variable not set"
	@echo "Usage: make clean-job JOB=<job-name>"
	@exit 1
endif
	@echo "Cleaning build files for $(JOB)..."
	@rm -rf build/$(JOB)
	@echo "Build files for $(JOB) cleaned."

# Watch and rebuild on changes (requires entr)
watch:
ifndef JOB
	@echo "Error: JOB variable not set"
	@echo "Usage: make watch JOB=<job-name>"
	@exit 1
endif
	@echo "Watching for changes in jobs/$(JOB)/ and src/"
	@find jobs/$(JOB) src -name "*.tex" | entr -c make job JOB=$(JOB)