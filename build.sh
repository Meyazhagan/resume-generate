#!/bin/bash
# build.sh - Build script for LaTeX resume/CV

set -e

if [ $# -eq 0 ]; then
    echo "Usage: $0 <job-name>"
    echo "Example: $0 software-engineer-abc"
    exit 1
fi

JOB_NAME=$1
JOB_DIR="jobs/$JOB_NAME"
BUILD_DIR="build/$JOB_NAME"

# Check if job directory exists
if [ ! -d "$JOB_DIR" ]; then
    echo "Error: Job directory '$JOB_DIR' does not exist"
    echo "Available jobs:"
    find jobs -maxdepth 1 -type d -not -path jobs | sed 's|jobs/||' | sort
    exit 1
fi

# Check if job.tex exists
if [ ! -f "$JOB_DIR/job.tex" ]; then
    echo "Error: $JOB_DIR/job.tex not found"
    echo "Create it by copying from src/main.tex and customizing"
    exit 1
fi

# Create build directory
mkdir -p "$BUILD_DIR"

echo "Building resume for job: $JOB_NAME"
echo "Source: $JOB_DIR/job.tex"
echo "Output: $BUILD_DIR/"

# Change to job directory for relative imports
cd "$JOB_DIR"

# Run pdflatex
pdflatex -synctex=1 -interaction=nonstopmode -file-line-error -output-directory="../../$BUILD_DIR" job.tex

# Check if PDF was generated successfully
if [ -f "../../$BUILD_DIR/job.pdf" ]; then
    echo "✅ Successfully built: $BUILD_DIR/job.pdf"
    
    # Optional: Open the PDF (uncomment for your OS)
    # macOS: open "../../$BUILD_DIR/job.pdf"
    # Linux: xdg-open "../../$BUILD_DIR/job.pdf"
    # Windows: start "../../$BUILD_DIR/job.pdf"
else
    echo "❌ Build failed! Check the log file: $BUILD_DIR/job.log"
    exit 1
fi

echo "Build complete!"