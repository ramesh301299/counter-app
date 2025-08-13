# Firebase Setup Instructions

To complete the Firebase setup for your Counter App, follow these steps:

## 1. Create a Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project" or select an existing project
3. Enter your project name and follow the setup wizard

## 2. Add Android App to Firebase

1. In Firebase Console, click "Add app" and select Android
2. Enter the package name: `com.example.counter_app`
3. Download the `google-services.json` file
4. Replace the placeholder file at `android/app/google-services.json` with your downloaded file

## 3. Enable Authentication

1. In Firebase Console, go to "Authentication" in the left sidebar
2. Click "Get started"
3. Go to "Sign-in method" tab
4. Enable "Email/Password" authentication

## 4. Initialize Firebase (Optional - for web support)

If you want to add web support:
1. Add a web app in Firebase Console
2. Copy the Firebase config
3. Create `lib/firebase_options.dart` with FlutterFire CLI:
   ```bash
   flutter pub global activate flutterfire_cli
   flutterfire configure
   ```

## 5. Run the App

After completing the setup:
```bash
flutter clean
flutter pub get
flutter run
```

## Important Notes

- The current `google-services.json` is a placeholder. You MUST replace it with your actual file from Firebase Console
- Make sure you have enabled Email/Password authentication in Firebase Console
- The minimum SDK version has been set to 21 for Firebase compatibility
- All necessary Gradle configurations have been added

## Troubleshooting

If you encounter issues:
1. Ensure you've replaced the placeholder `google-services.json` with your actual file
2. Check that Email/Password authentication is enabled in Firebase Console
3. Run `flutter clean` and rebuild the project
4. Check that your package name matches exactly: `com.example.counter_app`