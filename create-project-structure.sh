#!/bin/bash

# Function to create directory if it doesn't exist
create_dir() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
        echo "Created directory: $1"
    fi
}

# Function to create feature directories
create_feature_dirs() {
    local feature_name=$1
    echo "Creating directories for feature: $feature_name"
    
    create_dir "lib/src/features/$feature_name/data/models"
    create_dir "lib/src/features/$feature_name/data/sources"
    create_dir "lib/src/features/$feature_name/domain/entities"
    create_dir "lib/src/features/$feature_name/domain/repositories"
    create_dir "lib/src/features/$feature_name/domain/usecases"
    create_dir "lib/src/features/$feature_name/presentation/screens"
    create_dir "lib/src/features/$feature_name/presentation/widgets"
    create_dir "lib/src/features/$feature_name/presentation/providers"
}

# Function to display usage instructions
show_usage() {
    echo "Usage: $0 [OPTIONS] feature1 [feature2 feature3 ...]"
    echo ""
    echo "Options:"
    echo "  -h, --help     Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 auth           # Create structure for single feature 'auth'"
    echo "  $0 auth profile   # Create structure for multiple features"
    echo ""
    echo "Note: Feature names should be lowercase and contain only letters, numbers, and underscores"
}

# Check for help flag
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_usage
    exit 0
fi

# Check if feature names are provided
if [ $# -eq 0 ]; then
    echo "Error: Please provide at least one feature name"
    show_usage
    exit 1
fi

# Validate feature names
for feature in "$@"; do
    if [[ ! "$feature" =~ ^[a-z0-9_]+$ ]]; then
        echo "Error: Invalid feature name '$feature'. Feature names should be lowercase and contain only letters, numbers, and underscores."
        exit 1
    fi
done

# Create core directories
echo "Creating core directories..."
create_dir "lib/src/core/api"
create_dir "lib/src/core/constants"
create_dir "lib/src/core/router"
create_dir "lib/src/core/storage"

# Create directories for each feature
for feature in "$@"; do
    create_feature_dirs "$feature"
done

# Create shared directories
echo "Creating shared directories..."
create_dir "lib/src/shared/providers"
create_dir "lib/src/shared/widgets"


# Create README.md
cat > README.md << EOL
# Yangasc

A Flutter application following clean architecture principles.

## Project Structure

\`\`\`
lib/
├── core/ # Core functionality and utilities
│ ├── api/ # API related code
│ ├── constants/ # App-wide constants
│ ├── router/ # Navigation/routing
│ └── storage/ # Local storage functionality
├── features/ # Feature-based modules
$(for feature in "$@"; do
    echo "│ └── $feature/ # Feature directory"
    echo "│ ├── data/ # Data layer"
    echo "│ │ ├── models/"
    echo "│ │ ├── repositories/"
    echo "│ │ └── sources/"
    echo "│ ├── domain/ # Business logic"
    echo "│ │ ├── entities/"
    echo "│ │ ├── repositories/"
    echo "│ │ └── usecases/"
    echo "│ └── presentation/"
    echo "│ ├── screens/"
    echo "│ ├── widgets/"
    echo "│ └── providers/"
done)
└── shared/ # Shared components and utilities
├── providers/ # App-wide providers
└── widgets/ # Reusable widgets
\`\`\`

## Getting Started

1. Run \`flutter pub get\` to install dependencies
2. Run \`flutter pub run build_runner build\` to generate code
3. Start developing!

## Architecture

This project follows clean architecture principles with:
- Feature-based organization
- Riverpod for state management
- GoRouter for navigation
- Clean separation of concerns
EOL

echo "Project structure created successfully!"
echo "Features created: $@"
echo "Run 'chmod +x create_project_structure.sh' to make the script executable"
echo "Run './create_project_structure.sh' to create the structure" 