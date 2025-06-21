# ✈️ Flight Review Sharing App

This Flutter app allows users to share their flight experiences by uploading images, selecting flight details (airports, airline, class), writing feedback, choosing a travel date, and giving a star rating.

## 🔐 Authentication
- Firebase Authentication (Email & Password)
- Login & Registration screens
- Auth state persistence

## 📦 Features
- Image upload via gallery picker
- Dynamic dropdowns for departure, arrival, airline, and travel class
- Message input
- Travel date picker
- Star rating system
- Firebase Auth integration

## 🛠 Tech Stack
- Flutter
- Firebase Auth
- Dart
- flutter_rating_bar
- image_picker

## 🚀 Getting Started
1. Clone this repo
2. Run `flutter pub get`
3. Connect Firebase project (Android + iOS)
4. Replace `google-services.json` or `GoogleService-Info.plist` in respective folders
5. Run `flutter run`

## 📁 Folder Structure
      /lib
      ┣ /screens
      ┃ ┣ login_screen.dart
      ┃ ┣ register_screen.dart
      ┃ ┗ share_experience_screen.dart
      ┣ main.dart
      ┗ auth_service.dart
      
## 🧪 To-Do / Improvements
- Firebase Firestore to save submitted data
- Image upload to Firebase Storage
- Admin moderation panel
- Real-time suggestions for airport/airline fields

## 📸 UI Sample
![Airline_review_4](https://github.com/user-attachments/assets/89cf92bf-bcd4-4498-beae-1ded003d239d)


