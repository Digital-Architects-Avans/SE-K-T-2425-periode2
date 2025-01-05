#!/bin/bash

# ===============================
# NUnit Test Runner Script
# ===============================

# Variables
PROJECT_DIR="$(pwd)"  # Current working directory
TEST_PROJECT="DetermineShippingCosts.csproj"
LOG_FILE="test_results.log"

# Step 1: Verify .NET SDK Installation
if ! command -v dotnet &> /dev/null; then
    echo ".NET SDK is not installed. Please install .NET SDK."
    exit 1
fi

# Step 2: Navigate to Project Directory
echo "Navigating to project directory: $PROJECT_DIR"
cd "$PROJECT_DIR" || { echo "Failed to navigate to project directory"; exit 1; }

# Step 3: Restore Dependencies
echo "Restoring dependencies..."
dotnet restore "$TEST_PROJECT"
if [ $? -ne 0 ]; then
    echo "Failed to restore dependencies."
    exit 1
fi

# Step 4: Build the Test Project
echo "🔨 Building the NUnit test project..."
dotnet build "$TEST_PROJECT" --configuration Release
if [ $? -ne 0 ]; then
    echo "Build failed."
    exit 1
fi

# Step 5: Run NUnit Tests
echo "Running NUnit tests..."
dotnet test "$TEST_PROJECT" \
  --logger "console;verbosity=detailed" \
  --filter "FullyQualifiedName~DetermineShippingCostsTest" \
  --results-directory ./TestResults \
  --no-build | tee "$LOG_FILE"

# Step 6: Verify Test Results
if [ $? -eq 0 ]; then
    echo "All NUnit tests passed successfully!"
    exit 0
else
    echo "Some NUnit tests failed. Check the log file: $LOG_FILE"
    exit 1
fi
