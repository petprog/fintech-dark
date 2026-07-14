# Fintech Dashboard Flutter Assessment

A modern fintech dashboard application built with Flutter as part of a technical assessment.

The application demonstrates a scalable Flutter architecture with responsive UI, state management, dependency injection, reusable components, and tested business logic.

## Demo

<p align="center">
  <img 
    src="https://github.com/user-attachments/assets/af23d24f-0251-4c38-b03c-85fdb78d3b0a" 
    alt="Fintech Dashboard Demo" 
    width="350"
  />
</p>

## Overview

The app simulates a fintech banking dashboard experience where users can:

* View account balance
* Review recent transactions
* Manage cards
* View notifications
* Access profile settings
* Interact with responsive dashboard components

The focus of the implementation was on creating a maintainable production-style Flutter application rather than only building static screens.

## Features

* Dashboard overview
* Balance card with account information
* Recent transaction history
* Card management
* Card freeze/unfreeze interaction
* Notifications section
* Profile management
* Responsive layouts for different screen sizes
* Loading and empty states
* Error handling
* Unit tested business logic

## Tech Stack

### Core

* Flutter
* Dart

### Architecture

* Clean Architecture
* Feature-first project structure
* Repository Pattern
* Separation of presentation, domain, and data layers

### State Management

* Flutter BLoC

### Dependency Injection

* GetIt
* Injectable

### Networking & Data

* Dio for API communication
* Shared Preferences for local persistence
* Dartz for functional error handling

### UI & Utilities

* Go Router for navigation
* FL Chart for data visualization
* Flutter SVG support
* Cached network images
* Shimmer loading effects

### Testing

* Flutter Test
* Bloc Test
* Mocktail

## Project Structure

```
lib/
├── app/
│   └── router/
│
├── common/
│   └── widgets/
│
├── core/
│   ├── errors/
│   ├── network/
│   ├── theme
│   └── di/
│
├── features/
│   └── dashboard/
│       ├── data/
│       │   ├── models/
│       │   └── repositories/
│       │
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       │
│       └── presentation/
│           ├── components/
│           ├── bloc/
│           ├── pages/
│           └── widgets/
│
└── main.dart
```

## Implementation Notes

### Architecture Decisions

The application follows Clean Architecture principles to keep business logic independent from UI implementation.

The layers are separated as:

**Presentation Layer**

* Handles UI rendering
* Contains BLoC state management
* Responds to user interactions

**Domain Layer**

* Contains business rules
* Defines entities and use cases
* Independent of external frameworks

**Data Layer**

* Handles external data sources
* Converts models into domain entities
* Implements repository contracts

This structure makes the application easier to test, maintain, and scale.

## State Management

BLoC was selected because it provides:

* Clear separation between UI and business logic
* Predictable state transitions
* Easier unit testing
* Better scalability for complex applications

## Dependency Injection

Dependency injection is handled using GetIt and Injectable.

Benefits:

* Reduces tight coupling
* Improves testability
* Makes replacing implementations easier

## Testing Strategy

The project includes unit tests around business logic.

Testing covers:

* BLoC state changes
* Repository behaviour
* Use case execution
* Widget behaviour for different screen sizes

Mocktail is used to create test doubles for dependencies.

## Setup Instructions

### Prerequisites

Ensure you have:

* Flutter SDK installed
* Dart SDK installed
* Android Studio or Xcode configured
* Emulator or physical device available

Check your Flutter installation:

```bash
flutter doctor
```

### Installation

Clone the repository:

```bash
git clone https://github.com/petprog/fintech-dark.git
```

Navigate into the project:

```bash
cd fintech-dark
```

Install dependencies:

```bash
flutter pub get
```

Generate dependency injection and serialization files:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Run the application:

```bash
flutter run
```

## Running Tests

Run all tests:

```bash
flutter test
```

## Build

Android:

```bash
flutter build apk
```

iOS:

```bash
flutter build ios
```

## Author

Built as part of a Flutter technical assessment.
