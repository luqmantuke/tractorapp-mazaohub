# MazaoHub Tractor App

A Flutter application following clean architecture principles.

## Project Structure

```
lib/
├── core/ # Core functionality and utilities
│ ├── api/ # API related code
│ ├── constants/ # App-wide constants
│ ├── router/ # Navigation/routing
│ └── storage/ # Local storage functionality
├── features/ # Feature-based modules
│ └── auth/ # Feature directory
│ ├── data/ # Data layer
│ │ ├── models/
│ │ ├── repositories/
│ │ └── sources/
│ ├── domain/ # Business logic
│ │ ├── entities/
│ │ ├── repositories/
│ │ └── usecases/
│ └── presentation/
│ ├── screens/
│ ├── widgets/
│ └── providers/
│ └── profile/ # Feature directory
│ ├── data/ # Data layer
│ │ ├── models/
│ │ ├── repositories/
│ │ └── sources/
│ ├── domain/ # Business logic
│ │ ├── entities/
│ │ ├── repositories/
│ │ └── usecases/
│ └── presentation/
│ ├── screens/
│ ├── widgets/
│ └── providers/
│ └── mechanical_owner/ # Feature directory
│ ├── data/ # Data layer
│ │ ├── models/
│ │ ├── repositories/
│ │ └── sources/
│ ├── domain/ # Business logic
│ │ ├── entities/
│ │ ├── repositories/
│ │ └── usecases/
│ └── presentation/
│ ├── screens/
│ ├── widgets/
│ └── providers/
│ └── farmer/ # Feature directory
│ ├── data/ # Data layer
│ │ ├── models/
│ │ ├── repositories/
│ │ └── sources/
│ ├── domain/ # Business logic
│ │ ├── entities/
│ │ ├── repositories/
│ │ └── usecases/
│ └── presentation/
│ ├── screens/
│ ├── widgets/
│ └── providers/
│ └── agent/ # Feature directory
│ ├── data/ # Data layer
│ │ ├── models/
│ │ ├── repositories/
│ │ └── sources/
│ ├── domain/ # Business logic
│ │ ├── entities/
│ │ ├── repositories/
│ │ └── usecases/
│ └── presentation/
│ ├── screens/
│ ├── widgets/
│ └── providers/
│ └── common/ # Feature directory
│ ├── data/ # Data layer
│ │ ├── models/
│ │ ├── repositories/
│ │ └── sources/
│ ├── domain/ # Business logic
│ │ ├── entities/
│ │ ├── repositories/
│ │ └── usecases/
│ └── presentation/
│ ├── screens/
│ ├── widgets/
│ └── providers/
└── shared/ # Shared components and utilities
├── providers/ # App-wide providers
└── widgets/ # Reusable widgets
```

## Getting Started

1. Run `flutter pub get` to install dependencies
2. Run `flutter pub run build_runner build` to generate code
3. Start developing!

## Architecture

This project follows clean architecture principles with:

- Feature-based organization
- Riverpod for state management
- GoRouter for navigation
- Clean separation of concerns
