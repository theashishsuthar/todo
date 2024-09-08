# TODO Project README

## Overview

This Flutter project is built using the Clean Architecture pattern, the BLoC (Business Logic Component) pattern for state management, and the Freezer package for immutable data models. It employs the `hive` package for local data storage and Firebase Cloud Firestore for cloud-based data synchronization. Additionally, Fastlane is used for deployment automation, and the project includes localization support for Arabic.

## Project Structure

The project is organized following Clean Architecture principles, which separate concerns into distinct layers:

- **Presentation Layer**: Contains UI components and the BLoC files responsible for managing the state of the UI.
- **Domain Layer**: Holds business logic and domain entities. It defines use cases and repository interfaces.
- **Data Layer**: Implements the data sources and repositories. It handles data fetching from both local storage (`hive`) and remote sources (Firebase Firestore).

## Dependencies

- **Flutter**:  Latest stable version
- **BLoC**: For state management
- **Freezer**: For immutable data models
- **Hive**: For local data storage
- **Firebase**: For cloud-based data storage and synchronization
- **Fastlane**: For deployment automation

## Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/your-repo/flutter-project.git
   cd flutter-project
   ```

2. **Install Flutter and Dart SDK:**

   Follow the official Flutter [installation guide](https://flutter.dev/docs/get-started/install).

3. **Install dependencies:**

   Run the following command to fetch all dependencies:

   ```bash
   flutter pub get
   ```

4. **Setup Firebase:**

   - Go to the [Firebase Console](https://console.firebase.google.com/).
   - Create a new project or use an existing one.
   - Add your Flutter app to the Firebase project and follow the instructions to download the `google-services.json` file.
   - Place `google-services.json` in the `android/app` directory of your project.

5. **Setup Hive:**

   - Initialize Hive in your application. Add the initialization code in your `main.dart` file:

     ```dart
     void main() async {
       WidgetsFlutterBinding.ensureInitialized();
       await Hive.initFlutter();
       runApp(MyApp());
     }
     ```

6. **Set up localization:**

   - Make sure the `flutter_localizations` package is included in your `pubspec.yaml`.
   - Create and add ARB files for localization (e.g., `lib/l10n/intl_ar.arb` for Arabic).

7. **Configure Fastlane:**

   - Navigate to `android/` and `ios/` directories.
   - Follow the [Fastlane setup guide](https://docs.fastlane.tools/getting-started/) to configure your deployment lanes.

## Running the App

To run the app on an emulator or connected device, use:

```bash
flutter run
```

## Building the App

To build the app for release:

- **Android:**

  ```bash
  flutter build apk --release
  ```

- **iOS:**

  ```bash
  flutter build ios --release
  ```

## Deployment

Use Fastlane to deploy the app:

- **Android:**

  ```bash
  cd android
  fastlane android beta
  ```

- **iOS:**

  ```bash
  cd ios
  fastlane ios beta
  ```

## Localization

This project currently supports Arabic. To add support for additional languages, follow these steps:

1. Add new ARB files to the `lib/l10n` directory.
2. Update the `pubspec.yaml` file to include the new ARB files.
3. Run `flutter pub get` to update the localization files.

## Testing

Run unit tests and widget tests using:

```bash
flutter test
```


## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

For any issues or questions, please open an issue on the GitHub repository or contact the project maintainers.

