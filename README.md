# CancApp


CancApp is a comprehensive mobile application built with Flutter, designed to support cancer patients through their treatment journey. It provides a suite of tools to manage health records, track appointments, communicate with healthcare providers, and connect with a supportive community. The app caters to various user roles including patients, doctors, pharmacists, and volunteers.

## ✨ Key Features

-   **User Roles & Authentication:** Secure sign-up and login for Patients, Doctors, Pharmacists, Psychiatrists, and Volunteers with email verification and password recovery.
-   **Community Hub:** A social feed for users to share experiences, post updates with images, comment, and react, fostering a supportive environment.
-   **Real-time Chat:** Direct messaging between different user roles, enabling seamless communication.
-   **AI Chatbot:** An integrated chatbot to provide instant assistance and answer user queries.
-   **Medication & Appointment Reminders:** A robust system for scheduling and receiving local notifications for medications and doctor visits, with customizable frequencies (daily, specific days, intervals).
-   **Health Record Management:** Users can upload and organize medical documents, lab results, prescriptions, and scans.
-   **Find Nearest Pharmacies:** A location-based feature using Google Maps to find and view nearby pharmacies.
-   **Profile Management:** Users can edit their profile information and change their password with biometric authentication for added security.
-   **Multi-language Support:** The app is fully localized for both English and Arabic.

## 🛠️ Tech Stack & Architecture

The application is built using a modern and scalable tech stack, following Clean Architecture principles to ensure a clear separation of concerns.

-   **Architecture:** The project is structured by feature, separating the codebase into three main layers:
    -   **Data:** Handles data retrieval from local (Hive, SharedPreferences) and remote (Dio) sources.
    -   **Presentation (UI):** Consists of Widgets and state management (Bloc/Cubit) to display data and handle user interactions.

-   **Core Technologies:**
    -   **Framework:** Flutter
    -   **State Management:** `flutter_bloc` / `Cubit`
    -   **Navigation:** `go_router` for a declarative, URL-based routing system.
    -   **Networking:** `dio` for HTTP requests with interceptors for authentication and token refresh.
    -   **Dependency Injection:** `get_it` for service locator pattern.
    -   **Local Storage:** `hive` for structured data, `shared_preferences` for simple key-value data, and `flutter_secure_storage` for sensitive credentials.
    -   **Asynchronous Programming:** `dartz` for functional programming constructs (Either).
    -   **Services:** `google_maps_flutter`, `location`, `flutter_local_notifications`.

## ⚙️ Getting Started

### Prerequisites

-   Flutter SDK (version 3.27.0 or higher)
-   An editor like VS Code or Android Studio
-   A device or emulator to run the app

### Installation

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/mo7amed-soliman/cancapp.mobile.git
    cd cancapp.mobile
    ```

2.  **Install dependencies:**
    ```sh
    flutter pub get
    ```

### Environment Configuration

Before running the app, you need to set up your environment variables and API keys.

1.  **Create a `.env` file** in the root of the project with the following keys:
    ```env
    API_BASE_URL=http://your-api-url.com/api/
    CHAT_BOT_BASE_URL=http://your-chatbot-api-url.com/
    ```

2.  **Add Google Maps API Key:**
    -   **Android:** In `android/app/src/main/AndroidManifest.xml`, replace the placeholder with your API key:
        ```xml
        <meta-data android:name="com.google.android.geo.API_KEY"
               android:value="YOUR_GOOGLE_MAPS_API_KEY_HERE"/>
        ```
    -   **iOS:** In `ios/Runner/AppDelegate.swift`, replace the placeholder with your API key:
        ```swift
        GMSServices.provideAPIKey("YOUR_GOOGLE_MAPS_API_KEY_HERE")
        ```

### Running the App

Execute the following command to run the application:
```sh
flutter run
```

## 📂 Project Structure

The project follows a feature-driven directory structure to maintain a clean and scalable codebase.

```
lib
├── core/                  # Shared logic and utilities
│   ├── cubits/            # Global state management
│   ├── di/                # Dependency injection setup
│   ├── helpers/           # Utilities, extensions, DB helpers
│   ├── models/            # Core data models (e.g., UserModel)
│   ├── networking/        # API client, endpoints, interceptors
│   ├── routing/           # GoRouter configuration and routes
│   ├── services/          # Background services (notifications, location)
│   ├── shared_feature/    # Features common across user types
│   ├── theming/           # App-wide themes, colors, styles
│   └── widgets/           # Common reusable widgets
│
├── users/                 # User role-specific features
│   ├── patient/           # Features exclusive for the patient role
│   │   ├── chat/
│   │   ├── chatbot/
│   │   ├── home/
│   │   ├── profile/
│   │   ├── record/
│   │   └── reminder/
│   ├── doctor/            # Views and logic for doctors
│   └── pharmacist/        # Views and logic for pharmacists
│
├── l10n/                  # Localization files (arb)
├── generated/             # Auto-generated localization code
└── main.dart              # App entry point
