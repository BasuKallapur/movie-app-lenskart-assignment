import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class ApiService {
  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static const String _apiKey = 'your_api_key_here'; // Replace with actual API key
  static const String _imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  // For demo purposes, we'll use mock data if API key is not set
  static bool get _hasValidApiKey => _apiKey != 'your_api_key_here';

  static Future<List<Movie>> getPopularMovies({int page = 1}) async {
    if (!_hasValidApiKey) {
      return _getMockMovies();
    }

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/movie/popular?api_key=$_apiKey&page=$page'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['results'];
        return results.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      return _getMockMovies();
    }
  }

  static Future<List<Movie>> searchMovies(String query, {int page = 1}) async {
    if (!_hasValidApiKey) {
      return _getMockMovies().where((movie) => 
        movie.title.toLowerCase().contains(query.toLowerCase())
      ).toList();
    }

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/search/movie?api_key=$_apiKey&query=$query&page=$page'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['results'];
        return results.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search movies');
      }
    } catch (e) {
      return [];
    }
  }

  static List<Movie> _getMockMovies() {
    return [
      Movie(
        id: 1,
        title: 'The Shawshank Redemption',
        overview: 'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.',
        posterPath: '/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg',
        backdropPath: '/iNh3BivHyg5sQRPP1KOkzguEX0H.jpg',
        voteAverage: 9.3,
        releaseDate: '1994-09-23',
        genreIds: [18, 80],
      ),
      Movie(
        id: 2,
        title: 'The Godfather',
        overview: 'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.',
        posterPath: '/3bhkrj58Vtu7enYsRolD1fZdja1.jpg',
        backdropPath: '/tmU7GeKVybMWFButWEGl2M4GeiP.jpg',
        voteAverage: 9.2,
        releaseDate: '1972-03-24',
        genreIds: [18, 80],
      ),
      Movie(
        id: 3,
        title: 'The Dark Knight',
        overview: 'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests.',
        posterPath: '/qJ2tW6WMUDux911r6m7haRef0WH.jpg',
        backdropPath: '/hqkIcbrOHL86UncnHIsHVcVmzue.jpg',
        voteAverage: 9.0,
        releaseDate: '2008-07-18',
        genreIds: [28, 80, 18],
      ),
      Movie(
        id: 4,
        title: 'Pulp Fiction',
        overview: 'The lives of two mob hitmen, a boxer, a gangster and his wife intertwine in four tales of violence and redemption.',
        posterPath: '/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg',
        backdropPath: '/4cDFJr4HnXN5AdPw4AKrmLlMWdO.jpg',
        voteAverage: 8.9,
        releaseDate: '1994-10-14',
        genreIds: [80, 18],
      ),
      Movie(
        id: 5,
        title: 'Forrest Gump',
        overview: 'The presidencies of Kennedy and Johnson, the events of Vietnam, Watergate and other historical events unfold from the perspective of an Alabama man.',
        posterPath: '/arw2vcBveWOVZr6pxd9XTd1TdQa.jpg',
        backdropPath: '/7c8obl4XlbdTjsLTyd8C6UZlbUb.jpg',
        voteAverage: 8.8,
        releaseDate: '1994-07-06',
        genreIds: [35, 18, 10749],
      ),
    ];
  }
}