import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/api_service.dart';
import '../widgets/movie_list.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Movie>> _popularMovies;
  late Future<List<Movie>> _nowPlayingMovies;
  late Future<List<Movie>> _comingSoonMovies;

  @override
  void initState() {
    super.initState();
    _popularMovies = _apiService.getPopularMovies();
    _nowPlayingMovies = _apiService.getNowPlayingMovies().then((movies) {
      final now = DateTime.now();
      return movies.where((movie) {
          final releaseDate = DateTime.parse(movie.releaseDate);
          return releaseDate.isBefore(now) || releaseDate.isAtSameMomentAs(now);
        }).toList()
        ..sort((a, b) {
          final aDate = DateTime.parse(a.releaseDate);
          final bDate = DateTime.parse(b.releaseDate);
          return aDate
              .difference(now)
              .abs()
              .compareTo(bDate.difference(now).abs());
        });
    });
    _comingSoonMovies = _apiService.getComingSoonMovies().then((movies) {
      final now = DateTime.now();
      return movies.where((movie) {
          final releaseDate = DateTime.parse(movie.releaseDate);
          return releaseDate.isAfter(now);
        }).toList()
        ..sort(
          (a, b) => DateTime.parse(
            a.releaseDate,
          ).compareTo(DateTime.parse(b.releaseDate)),
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Popular Movies',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              MovieList(future: _popularMovies),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Now in Cinemas',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              MovieList(future: _nowPlayingMovies),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Coming Soon',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              MovieList(future: _comingSoonMovies),
            ],
          ),
        ),
      ),
    );
  }
}
