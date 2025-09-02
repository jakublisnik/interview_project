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

### ⚡ **How to Run the Project**

1. Install [Flutter SDK](https://docs.flutter.dev/get-started/install).

2. **Clone the repository:**
   ```sh
   git clone https://github.com/jakublisnik/interview_project.git
   cd interview_project
   ```

3. **Install dependencies:**
   ```sh
   flutter pub get
   ```

4. **Run the project:**
   ```sh
   flutter run
   ```


## App preview (location Ostrava)

Android:

<img width="300"  alt="Screenshot_20250827_161017" src="https://github.com/user-attachments/assets/58deb3bc-fe21-433e-95c0-869dcf93e892" />

iOS:

<img width="300" height="2796" alt="simulator_screenshot_18A3422A-FAB4-41F4-BDC8-4A49D25E1476" src="https://github.com/user-attachments/assets/358d16b3-8a41-4cd2-9d6a-76366efc30e9" />


