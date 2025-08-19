
# 🧾 Lost & Found App – Frontend

## 📖 Project Description

The **Lost & Found App** is a user-friendly mobile solution for reporting, tracking, and retrieving misplaced belongings. Users can log in, upload lost/found items with details, and securely connect with others.  

This project is built with **Flutter**, following **MVVM Architecture** and using **Riverpod** for state management. It ensures a clean UI/UX, seamless usability, and accessibility across devices.

### 👥 Team Members & Responsibilities

- **Kalpesh**  
  - Frontend: `home_screen.dart`, `main_screen.dart`, `request_screen.dart`  
  - UI/UX: Navigation flow, bottom navigation bar, request handling  
  - Integration with `item_provider.dart`  

- **Kajol**  
  - Frontend: `login_screen.dart`, `signUp_screen.dart`  
  - UI/UX: Authentication flow (design & validation)  
  - Services: `auth_repo.dart` (Login/Signup API integration)  

- **Abhishek**  
  - Core: `api_client.dart`, `secure_storage.dart`  
  - Provider: `auth_provider.dart`  
  - UI/UX: Theming & consistency (`theme.dart`, `colors.dart`, `inputDecoration.dart`)  

- **Himanshi**  
  - Frontend: `profile_screen.dart`  
  - UI/UX: Profile layout & user detail management  
  - Services: `item_upload_repo.dart` (Item upload API integration)  
  - Widgets: `form_field.dart`  

- **Tejas**  
  - Models: `item_model.dart`, `item_display_model.dart`, `user_model.dart`  
  - Provider: `item_provider.dart`  
  - Frontend: `itemCard.dart`, `itemDetailsScreen.dart`  
  - Data binding between UI and model layer  

## 🏛️ Project Architecture

This project follows **MVVM (Model-View-ViewModel) Architecture** with **Riverpod** for state management:

- **Model** → Data structures & serialization (`item_model.dart`, `user_model.dart`, etc.)  
- **View** → UI screens (`home_screen.dart`, `profile_screen.dart`, etc.)  
- **ViewModel/Provider** → Business logic & state (`auth_provider.dart`, `item_provider.dart`)  
- **Repository/Services** → API interaction (`auth_repo.dart`, `item_upload_repo.dart`)  
- **Core** → Shared utilities (`api_client.dart`, `theme.dart`, `colors.dart`, `secure_storage.dart`)  

## 🚀 Getting Started

### ✅ Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)  
- Android Studio / VS Code with Flutter & Dart plugins  
- Emulator or physical device  

### 📦 Installation

```bash
# Clone the repository
git clone https://github.com/KalpeshJangir23/team-05_LTFS/tree/main/frontend-app

# Navigate to project folder
cd frontend-app/lostnfound

# Install dependencies
flutter pub get
```

### ▶️ Running the App

```bash
# Run on connected device
flutter run

# Run on specific emulator/device
flutter run -d emulator-5554
```

### 📱 Build Release APK

```bash
flutter build apk --release
```

### 📦 Build App Bundle (Play Store Upload)

```bash
flutter build appbundle --release
```

## 📸 Demo

App screenshots and demo video will be added here.

## 📂 Folder Structure

```
lib/
 ┣ core/         # Common utilities (API client, theme, storage)
 ┣ model/        # Data models
 ┣ presentation/ # Screens (UI Layer)
 ┣ provider/     # State management using Riverpod
 ┣ services/     # API Repositories
 ┗ main.dart     # App entry point
```

## ✨ Tech Stack

- **Framework:** Flutter
- **State Management:** Riverpod
- **Architecture:** MVVM
- **Language:** Dart

## 📖 Summary

The Lost & Found App simplifies reporting and recovering misplaced belongings with a secure, reliable, and well-structured Flutter application. Built with MVVM and Riverpod, it ensures scalability, modularity, and a smooth user experience.
