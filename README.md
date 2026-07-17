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
* Firebase CLI installed (`npm install -g firebase-tools`)
* FlutterFire CLI installed (`dart pub global activate flutterfire_cli`)
* A Firebase account with access to the project (or your own Firebase project, see note below)

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

### ⚠️ Firebase Configuration Required

> **Note:** This repository does **not** include the Firebase configuration/secret files needed to run the app (e.g. `google-services.json` for Android, `GoogleService-Info.plist` for iOS, and `lib/firebase_options.dart`). These are intentionally excluded from version control since they contain project-specific credentials.
>
> Without these files, the app **will fail to build or crash on launch** when it tries to initialize Firebase. You'll need to generate your own using the steps below before running the project.

### Configuring the Project with FlutterFire

1. **Log in to Firebase** (if you haven't already):

   ```bash
   firebase login
   ```

2. **Create or select a Firebase project**

   * Go to the [Firebase Console](https://console.firebase.google.com/) and create a new project (or use an existing one you have access to).
   * Enable the services this app relies on (e.g. Authentication, Firestore/Realtime Database, Cloud Messaging — enable whichever the app uses).

3. **Run the FlutterFire configuration command** from the root of the project:

   ```bash
   flutterfire configure
   ```

   This will:

   * Prompt you to select your Firebase project
   * Let you pick the platforms to configure (Android, iOS, etc.)
   * Automatically register the app with Firebase for each selected platform
   * Generate `lib/firebase_options.dart` in your project
   * Download and place `google-services.json` into `android/app/`
   * Download and place `GoogleService-Info.plist` into `ios/Runner/`

4. **Verify the generated files exist:**

   ```
   android/app/google-services.json
   ios/Runner/GoogleService-Info.plist
   lib/firebase_options.dart
   ```

5. **Initialize Firebase in `main.dart`** (already wired into the app, but confirm it points to the generated options):

   ```dart
   await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
   );
   ```

6. Re-run `flutter pub get` and `dart run build_runner build --delete-conflicting-outputs` if prompted after configuration.

Once these files are in place, the app should build and run normally.

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