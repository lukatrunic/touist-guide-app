# 🧭 Tourist Guide App

A Flutter mobile application that allows users to explore tourist sights, view detailed information, mark favorite places, and access saved favorites offline using local storage.

The app is developed as part of the course **Advanced Mobile Programming** at **Algebra University**.

## 📱 Features

- User authentication using Firebase (Sign up, Sign in, Sign out, Deactivate account)
- Browse a list of tourist sights
- View detailed information about each sight
- Mark and unmark sights as favorites
- Favorites are stored locally and available offline
- Modern UI with custom widgets and animations
- Responsive design for different screen sizes

## 🧠 Technologies Used

- Flutter
- Dart
- Firebase Authentication
- Riverpod (state management)
- Shared Preferences (local storage)
- REST API (Dio)
- Lottie animations

## 📦 Offline Support

Favorite sights are saved locally on the device using SharedPreferences, allowing users to access their favorites even when the device is offline.

## 📋 Project Structure

The project follows Clean Architecture principles and is organized into three main layers:

- **Presentation layer** (`presentation/`)  
  Contains UI screens, widgets, and state management (Riverpod Notifiers).  
  Features are grouped by domain (e.g. `auth`, `sights`, `profile`).  
  The `core` module inside presentation holds shared UI concerns such as routing, theming, and reusable widgets.

- **Domain layer** (`domain/`)  
  Contains business logic, domain models, repository interfaces, and use cases.  
  This layer is independent of frameworks and UI.

- **Data layer** (`data/`)  
  Contains API clients, local data handling, and repository implementations.  
  This layer is responsible for retrieving and persisting data.

This structure improves separation of concerns, readability, and maintainability.


## 🚀 Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/LukaTrunic/Touist-Guide-App.git

2. Install dependencies:
    ```bash
    flutter pub get

3. Run the app:
    ```bash
    flutter run

## ℹ️ Notes

The shared_preferences data folder is generated automatically on each device and is not included in the repository.

Internet connection is required to load tourist sights data.

## 👤 Author

Luka Trunić
Advanced Mobile Programming – Algebra University
