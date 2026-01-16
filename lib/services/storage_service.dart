import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/movie.dart';

class StorageService {
  static const String _favoritesKey = 'favorites';
  static const String _watchlistKey = 'watchlist';

  static Future<List<Movie>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getStringList(_favoritesKey) ?? [];
    return favoritesJson
        .map((json) => Movie.fromJson(jsonDecode(json)))
        .toList();
  }

  static Future<void> addToFavorites(Movie movie) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();
    
    if (!favorites.any((m) => m.id == movie.id)) {
      favorites.add(movie);
      final favoritesJson = favorites
          .map((movie) => jsonEncode(movie.toJson()))
          .toList();
      await prefs.setStringList(_favoritesKey, favoritesJson);
    }
  }

  static Future<void> removeFromFavorites(int movieId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();
    favorites.removeWhere((movie) => movie.id == movieId);
    
    final favoritesJson = favorites
        .map((movie) => jsonEncode(movie.toJson()))
        .toList();
    await prefs.setStringList(_favoritesKey, favoritesJson);
  }

  static Future<bool> isFavorite(int movieId) async {
    final favorites = await getFavorites();
    return favorites.any((movie) => movie.id == movieId);
  }

  static Future<List<Movie>> getWatchlist() async {
    final prefs = await SharedPreferences.getInstance();
    final watchlistJson = prefs.getStringList(_watchlistKey) ?? [];
    return watchlistJson
        .map((json) => Movie.fromJson(jsonDecode(json)))
        .toList();
  }

  static Future<void> addToWatchlist(Movie movie) async {
    final prefs = await SharedPreferences.getInstance();
    final watchlist = await getWatchlist();
    
    if (!watchlist.any((m) => m.id == movie.id)) {
      watchlist.add(movie);
      final watchlistJson = watchlist
          .map((movie) => jsonEncode(movie.toJson()))
          .toList();
      await prefs.setStringList(_watchlistKey, watchlistJson);
    }
  }

  static Future<void> removeFromWatchlist(int movieId) async {
    final prefs = await SharedPreferences.getInstance();
    final watchlist = await getWatchlist();
    watchlist.removeWhere((movie) => movie.id == movieId);
    
    final watchlistJson = watchlist
        .map((movie) => jsonEncode(movie.toJson()))
        .toList();
    await prefs.setStringList(_watchlistKey, watchlistJson);
  }

  static Future<bool> isInWatchlist(int movieId) async {
    final watchlist = await getWatchlist();
    return watchlist.any((movie) => movie.id == movieId);
  }
}