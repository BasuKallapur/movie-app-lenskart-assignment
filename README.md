# Movie Discovery App

A Flutter mobile application for discovering and managing movies using The Movie Database (TMDB) API.

## Features

- Splash screen with smooth navigation to main application
- Bottom navigation with Movies, Favorites, and Watchlist sections
- Browse popular movies with grid layout display
- Real-time movie search functionality
- Add movies to personal favorites list
- Maintain watchlist for movies to watch later
- Detailed movie information screen with ratings and overview
- In-app notification system for movie playback
- Responsive design supporting various screen sizes
- Material Design UI components

## Technical Stack

- **Framework**: Flutter
- **Language**: Dart
- **API**: The Movie Database (TMDB) API v3
- **Local Storage**: SharedPreferences
- **HTTP Client**: http package
- **UI Design**: Material Design

## Project Architecture

```
lib/
├── main.dart
├── models/
│   └── movie.dart
├── screens/
│   ├── splash_screen.dart
│   ├── home_screen.dart
│   ├── movies_screen.dart
│   ├── favorites_screen.dart
│   ├── watchlist_screen.dart
│   └── movie_detail_screen.dart
├── services/
│   ├── api_service.dart
│   └── storage_service.dart
└── widgets/
    ├── movie_card.dart
    ├── loading_widget.dart
    └── empty_state_widget.dart
```

## Installation and Setup

### Prerequisites

- Flutter SDK 3.0.0 or higher
- Android Studio or VS Code with Flutter extension
- Android emulator or physical Android device

### Setup Instructions

1. Clone the repository

   ```bash
   git clone <repository-url>
   cd movie-app-lenskart-assignment
   ```

2. Install dependencies

   ```bash
   flutter pub get
   ```

3. Run the application
   ```bash
   flutter run
   ```

### Building for Production

Generate release APK:

```bash
flutter build apk --release
```

Generate app bundle for Play Store:

```bash
flutter build appbundle --release
```

## API Integration

The application integrates with TMDB API v3 for movie data retrieval:

- **Popular Movies**: Fetches trending and popular movie listings
- **Movie Search**: Enables real-time search across movie database
- **Movie Details**: Retrieves comprehensive movie information
- **Image Assets**: Loads movie posters and backdrop images

## Data Persistence

Local data storage implemented using SharedPreferences:

- User favorites list persistence across app sessions
- Watchlist data maintained locally
- Efficient data serialization and retrieval

## User Interface

### Splash Screen

- Application branding with movie-themed iconography
- Automatic navigation after loading completion
- Consistent color scheme throughout application

### Main Navigation

- Bottom navigation bar with three primary sections
- Material Design navigation patterns
- Smooth transitions between screens

### Movies Screen

- Grid-based layout optimized for mobile viewing
- Search functionality with real-time filtering
- Movie cards displaying essential information
- Interactive elements for favorites and watchlist management

### Movie Details

- Full-screen movie information display
- Circular progress indicator for user ratings
- Action buttons for playback and list management
- Comprehensive movie metadata presentation

### Favorites and Watchlist

- Consistent grid layout with main movies screen
- Empty state handling with informative messaging
- Remove functionality for list management

## State Management

- Loading states during API operations
- Error handling with user-friendly messaging
- Empty state management for improved user experience
- Responsive UI updates based on user interactions

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0
  shared_preferences: ^2.2.2
  cupertino_icons: ^1.0.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
```

## Performance Considerations

- Efficient image loading and caching
- Optimized API calls with proper error handling
- Memory management for large movie datasets
- Responsive design for various device specifications

## Application Flow

1. Application launches with splash screen
2. User navigates to main interface with bottom navigation
3. Movies screen displays popular movies with search capability
4. Users can add movies to favorites or watchlist
5. Movie selection opens detailed information screen
6. Play button triggers in-app notification system
7. Favorites and watchlist screens provide personal movie management

## Code Quality

- Consistent code formatting and structure
- Proper error handling throughout application
- Clean separation of concerns between services and UI
- Comprehensive widget organization for maintainability
