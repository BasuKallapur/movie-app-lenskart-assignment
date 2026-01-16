import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/movie.dart';
import '../services/storage_service.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final StorageService _storageService = StorageService();
  bool _isFavorite = false;
  bool _isInWatchlist = false;

  @override
  void initState() {
    super.initState();
    _checkStatus();
  }

  Future<void> _checkStatus() async {
    final isFav = await _storageService.isFavorite(widget.movie.id);
    final isWatch = await _storageService.isInWatchlist(widget.movie.id);
    setState(() {
      _isFavorite = isFav;
      _isInWatchlist = isWatch;
    });
  }

  Future<void> _toggleFavorite() async {
    if (_isFavorite) {
      await _storageService.removeFromFavorites(widget.movie.id);
    } else {
      await _storageService.addToFavorites(widget.movie);
    }
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  Future<void> _toggleWatchlist() async {
    if (_isInWatchlist) {
      await _storageService.removeFromWatchlist(widget.movie.id);
    } else {
      await _storageService.addToWatchlist(widget.movie);
    }
    setState(() {
      _isInWatchlist = !_isInWatchlist;
    });
  }

  void _playMovie() {
    // Show in-app notification
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Movie is Playing'),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.green,
      ),
    );

    // Haptic feedback
    HapticFeedback.lightImpact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: widget.movie.backdropPath.isNotEmpty
                  ? Image.network(
                      widget.movie.fullBackdropUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Center(
                            child: Icon(Icons.movie, size: 100, color: Colors.grey),
                          ),
                        );
                      },
                    )
                  : Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.movie, size: 100, color: Colors.grey),
                      ),
                    ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    widget.movie.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Rating and Release Date
                  Row(
                    children: [
                      // Rating Circle
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _getRatingColor(widget.movie.voteAverage),
                        ),
                        child: Center(
                          child: Text(
                            '${(widget.movie.voteAverage * 10).toInt()}%',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'User Score',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Release Date: ${widget.movie.releaseDate}',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _playMovie,
                          icon: const Icon(Icons.play_arrow),
                          label: const Text('Play Now'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        onPressed: _toggleFavorite,
                        icon: Icon(
                          _isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: _isFavorite ? Colors.red : Colors.grey,
                        ),
                      ),
                      IconButton(
                        onPressed: _toggleWatchlist,
                        icon: Icon(
                          _isInWatchlist ? Icons.watch_later : Icons.watch_later_outlined,
                          color: _isInWatchlist ? Colors.blue : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Overview
                  const Text(
                    'Overview',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.movie.overview.isNotEmpty 
                        ? widget.movie.overview 
                        : 'No overview available.',
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 24),

                  // Genres (if available)
                  if (widget.movie.genres.isNotEmpty) ...[
                    const Text(
                      'Genres',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: widget.movie.genres.map((genre) {
                        return Chip(
                          label: Text(genre),
                          backgroundColor: Colors.grey[200],
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getRatingColor(double rating) {
    if (rating >= 7.0) return Colors.green;
    if (rating >= 5.0) return Colors.orange;
    return Colors.red;
  }
}