# Flutter Survey App

A cross-platform mobile survey application built with Flutter, featuring offline data collection and storage capabilities using Hive.

## Features

- Multi-step survey questionnaire
- Offline data storage using Hive
- Save and continue later functionality
- Cross-platform support (Android & iOS)
- Progress tracking
- Data synchronization when online

## Key Features Implementation

### Offline Storage

- Uses Hive boxes to store survey responses locally
- Automatic saving of progress
- Resume functionality from last saved point

### Survey Structure

- Multi-page survey support
- Different question types (multiple choice, text, numeric, etc.)
- Form validation
- Progress indicator

### Data Management

- Local data persistence
- Export functionality
- Data backup options

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Technical Stack

- Flutter SDK
- Hive for local storage
- Provider/Bloc for state management
- Flutter Form Builder for survey forms

## Project Structure

lib/
├── models/
│ ├── survey.dart
│ ├── question.dart
│ └── response.dart
├── screens/
│ ├── home_screen.dart
│ ├── survey_screen.dart
│ └── saved_surveys_screen.dart
├── services/
│ ├── hive_service.dart
│ └── survey_service.dart
├── widgets/
│ └── survey_components/
└── main.dart

yaml
dependencies:
flutter:
sdk: flutter
hive: ^2.2.3
hive_flutter: ^1.1.0
provider: ^6.0.5
flutter_form_builder: ^9.1.0
path_provider: ^2.1.1
