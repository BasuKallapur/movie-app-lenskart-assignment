import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/storage_service.dart';
import '../screens/movie_detail_screen.dart';

class MovieCard extends StatefulWidget {
  final Movie movie;
  final VoidCallback? onFavoriteChanged;
  final VoidCallback? onWatchlistChanged;

  const MovieCard({
    super.key,
    required this.movie,
    this.onFavoriteChanged,
    this.onWatchlistChanged,
  });

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
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
    widget.onFavoriteChanged?.call();
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
    widget.onWatchlistChanged?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailScreen(movie: widget.movie),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                  color: Colors.grey[300],
                ),
                child: widget.movie.posterPath.isNotEmpty
                    ? ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                        child: Image.network(
                          widget.movie.fullPosterUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(Icons.movie, size: 50, color: Colors.grey),
                            );
                          },
                        ),
                      )
                    : const Center(
                        child: Icon(Icons.movie, size: 50, color: Colors.grey),
                      ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.movie.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          widget.movie.voteAverage.toStringAsFixed(1),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(
                            _isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: _isFavorite ? Colors.red : Colors.grey,
                            size: 20,
                          ),
                          onPressed: _toggleFavorite,
                        ),
                        IconButton(
                          icon: Icon(
                            _isInWatchlist ? Icons.watch_later : Icons.watch_later_outlined,
                            color: _isInWatchlist ? Colors.blue : Colors.grey,
                            size: 20,
                          ),
                          onPressed: _toggleWatchlist,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}