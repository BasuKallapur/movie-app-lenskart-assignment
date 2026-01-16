import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/api_service.dart';
import '../widgets/movie_card.dart';
import '../widgets/loading_widget.dart';
import '../widgets/empty_state_widget.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final ApiService _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();
  List<Movie> _movies = [];
  List<Movie> _searchResults = [];
  bool _isLoading = true;
  bool _isSearching = false;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _loadPopularMovies();
  }

  Future<void> _loadPopularMovies() async {
    try {
      setState(() {
        _isLoading = true;
        _error = '';
      });
      
      final movies = await _apiService.getPopularMovies();
      setState(() {
        _movies = movies;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _searchMovies(String query) async {
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _searchResults = [];
      });
      return;
    }

    try {
      setState(() {
        _isSearching = true;
        _error = '';
      });
      
      final results = await _apiService.searchMovies(query);
      setState(() {
        _searchResults = results;
        _isSearching = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isSearching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search movies...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _searchMovies('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: _searchMovies,
            ),
          ),
          
          // Movies List
          Expanded(
            child: _buildMoviesList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMoviesList() {
    if (_isLoading) {
      return const LoadingWidget();
    }

    if (_error.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(_error),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadPopularMovies,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final moviesToShow = _searchController.text.isNotEmpty ? _searchResults : _movies;

    if (moviesToShow.isEmpty) {
      return EmptyStateWidget(
        message: _searchController.text.isNotEmpty 
            ? 'No movies found for "${_searchController.text}"'
            : 'No movies available',
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: moviesToShow.length,
      itemBuilder: (context, index) {
        return MovieCard(movie: moviesToShow[index]);
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}