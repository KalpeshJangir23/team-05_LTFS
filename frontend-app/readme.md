
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

- App screenshots

<p align="center">
  <img src="https://github.com/user-attachments/assets/055d6c9c-9a71-4423-81c4-d0d04b9ea192" alt="Preview 01" width="250"/>
  <img src="https://github.com/user-attachments/assets/e30bd232-d6f0-40b6-b8fc-6d508b60c72d" alt="Preview 02" width="250"/>
  <img src="https://github.com/user-attachments/assets/56de51db-395d-4d68-9d8e-e27280e903fb" alt="Preview 03" width="250"/>
  <img src="https://github.com/user-attachments/assets/8c37f920-0bc1-482d-a997-e0cb38d08181" alt="Preview 04" width="250"/>
  <img src="https://github.com/user-attachments/assets/4734bd30-c7ef-404a-b79f-df2aa3dd5d71" alt="Preview 05" width="250"/>
</p>

- Admin access

<p align="center">
  <img src="https://github.com/user-attachments/assets/fb7c05a6-7d78-4e30-832c-95d732468de5" alt="Screenshot 04" width="250"/>
  <img src="https://github.com/user-attachments/assets/54b5756a-e98a-4172-8be5-6e2a5b540464" alt="Screenshot 03" width="250"/>
  <img src="https://github.com/user-attachments/assets/3b6339b3-1491-4b88-9db2-4db7ac4a7ac1" alt="Screenshot 02" width="250"/>
  <img src="https://github.com/user-attachments/assets/82f6460c-6761-4adf-a82f-f95420f95f6c" alt="Screenshot 01" width="250"/>
</p>

- Video demonstration
  
  https://github.com/user-attachments/assets/f93ec43a-ac05-437b-87b2-e28ffe996257


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
