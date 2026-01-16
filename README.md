# Movie Discovery App

A Flutter mobile application for discovering and managing movies using The Movie Database (TMDB) API.

## Features

- **Splash Screen**: Welcome screen with app branding
- **Movie Discovery**: Browse popular movies with search functionality
- **Favorites**: Save movies to your personal favorites list
- **Watchlist**: Add movies you want to watch later
- **Movie Details**: View detailed information including ratings, overview, and release date
- **Play Notification**: In-app notification when playing movies
- **Responsive Design**: Works on various phone sizes
- **Material Design**: Clean, modern UI following Material Design principles

## Screenshots

### Main Features

- Bottom navigation with Movies, Favorites, and Watchlist tabs
- Grid layout for movie browsing
- Search functionality for finding specific movies
- Detailed movie information screen

## Technical Stack

- **Framework**: Flutter (Dart)
- **API**: The Movie Database (TMDB) API v3
- **State Management**: StatefulWidget with setState
- **Local Storage**: SharedPreferences for favorites and watchlist
- **HTTP Client**: http package for API calls
- **UI**: Material Design components

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   └── movie.dart           # Movie data model
├── screens/
│   ├── splash_screen.dart   # Welcome/loading screen
│   ├── home_screen.dart     # Main navigation container
│   ├── movies_screen.dart   # Movie browsing and search
│   ├── favorites_screen.dart # User's favorite movies
│   ├── watchlist_screen.dart # Movies to watch later
│   └── movie_detail_screen.dart # Detailed movie information
├── services/
│   ├── api_service.dart     # TMDB API integration
│   └── storage_service.dart # Local data persistence
└── widgets/
    ├── movie_card.dart      # Movie display component
    ├── loading_widget.dart  # Loading state indicator
    └── empty_state_widget.dart # Empty state display
```

## Setup Instructions

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Android Studio or VS Code with Flutter extension
- Android emulator or physical device
- TMDB API key

### Installation

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd movie-app-lenskart-assignment
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Get TMDB API Key**

   - Visit [TMDB website](https://www.themoviedb.org/)
   - Create a free account
   - Go to Settings → API
   - Request API key (Developer option)
   - Copy your API key

4. **Configure API Key**

   - Open `lib/services/api_service.dart`
   - Replace the API key with your own:

   ```dart
   static const String _apiKey = 'YOUR_API_KEY_HERE';
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

## API Integration

The app uses TMDB API v3 for:

- **Popular Movies**: `/movie/popular`
- **Search Movies**: `/search/movie`
- **Movie Details**: `/movie/{movie_id}`

### API Features Used

- Movie posters and backdrop images
- Movie titles, overviews, and release dates
- User ratings and vote averages
- Search functionality

## Local Storage

Uses SharedPreferences to store:

- **Favorites**: List of user's favorite movies
- **Watchlist**: List of movies to watch later
- **Persistence**: Data survives app restarts

## State Management

- **Loading States**: Shows loading indicators during API calls
- **Error States**: Displays error messages with retry options
- **Empty States**: Shows appropriate messages when no data is available

## Responsive Design

- **Grid Layout**: Adapts to different screen sizes
- **Material Design**: Consistent with platform conventions
- **Touch Targets**: Appropriate sizes for mobile interaction

## Build Instructions

### Debug Build

```bash
flutter run
```

### Release APK

```bash
flutter build apk --release
```

### Release Bundle (for Play Store)

```bash
flutter build appbundle --release
```

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0 # HTTP client for API calls
  provider: ^6.1.1 # State management (if needed)
  shared_preferences: ^2.2.2 # Local storage
  cupertino_icons: ^1.0.2 # iOS-style icons

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0 # Linting rules
```

## Performance Considerations

- **Image Caching**: Network images are cached automatically
- **Lazy Loading**: Movies loaded as needed
- **Error Handling**: Graceful handling of network failures
- **Memory Management**: Proper disposal of controllers and resources

## Future Enhancements

- User authentication
- Movie trailers integration
- Social sharing features
- Offline mode support
- Advanced filtering and sorting
- Movie recommendations

## License

This project is created for educational purposes as part of a mobile development assignment.

## Contact

For questions or support, please contact the development team.
