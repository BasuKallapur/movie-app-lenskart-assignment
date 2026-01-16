import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/storage_service.dart';
import '../widgets/movie_card.dart';
import '../widgets/empty_state_widget.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  final StorageService _storageService = StorageService();
  List<Movie> _watchlist = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWatchlist();
  }

  Future<void> _loadWatchlist() async {
    try {
      final watchlist = await _storageService.getWatchlist();
      setState(() {
        _watchlist = watchlist;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _watchlist.isEmpty
              ? const EmptyStateWidget(
                  message: 'No movies in watchlist yet.\nAdd movies you want to watch later!',
                  icon: Icons.watch_later_outlined,
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: _watchlist.length,
                  itemBuilder: (context, index) {
                    return MovieCard(
                      movie: _watchlist[index],
                      onWatchlistChanged: () => _loadWatchlist(),
                    );
                  },
                ),
    );
  }
}