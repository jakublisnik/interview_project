# interview_project

## Project Overview

This is a sample Flutter project created for interview purposes. It demonstrates basic app structure, use of local database, and modular organization suitable for scalable development.

## Project Structure

```
interview_project/
├── android/           # Android platform-specific files
├── ios/               # iOS platform-specific files
├── assets/            # Static assets (e.g. databases)
│   └── databases/     # SQLite database files
├── lib/               # Main source code
│   ├── core/          # Core logic: database management, reusable services, and utility functions
│   │   ├── database/  # Database initialization and access logic
│   │   ├── services/  # Shared services (e.g. data providers, API clients)
│   │   └── utils/     # Utility functions and helpers used across the app
│   ├── features/      # Feature modules: encapsulated business logic for app sections
│   │   └── stations/  # Example feature: station management and related logic
│   └── ui/            # UI components: app entry point, theming, screens, and widgets
│       ├── app.dart   # Main app widget and navigation
│       ├── theme.dart # App-wide theme configuration
│       ├── screens/   # Individual screens/views of the app
│       └── widgets/   # Reusable UI widgets
├── test/              # Unit and widget tests
├── pubspec.yaml       # Project metadata and dependencies
└── README.md          # Project documentation
```

## Getting Started

1. Install [Flutter SDK](https://docs.flutter.dev/get-started/install).
2. Run `flutter pub get` to fetch dependencies.
3. Start the app with `flutter run`.

## Useful Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)

---

Feel free to extend this project structure for your own needs. For any questions, refer to the official Flutter documentation.
