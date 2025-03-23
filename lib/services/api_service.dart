import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class ApiService {
  static const String baseUrl = 'https://movies-api.nomadcoders.workers.dev';

  Future<List<Movie>> getPopularMovies() async {
    final response = await http.get(Uri.parse('$baseUrl/popular'));
    if (response.statusCode == 200) {
      print('Popular Movies Response: ${response.body}');
      final List<dynamic> data = json.decode(response.body)['results'];
      final movies = data.map((json) => Movie.fromJson(json)).toList();
      movies.sort((a, b) => b.voteAverage.compareTo(a.voteAverage));
      return movies;
    }
    throw Exception('Failed to load popular movies');
  }

  Future<List<Movie>> getNowPlayingMovies() async {
    final response = await http.get(Uri.parse('$baseUrl/now-playing'));
    if (response.statusCode == 200) {
      print('Now Playing Response: ${response.body}');
      final List<dynamic> data = json.decode(response.body)['results'];
      final movies = data.map((json) => Movie.fromJson(json)).toList();
      movies.sort((a, b) {
        final dateA = DateTime.parse(a.releaseDate);
        final dateB = DateTime.parse(b.releaseDate);
        return dateA.compareTo(dateB);
      });
      return movies;
    }
    throw Exception('Failed to load now playing movies');
  }

  Future<List<Movie>> getComingSoonMovies() async {
    final response = await http.get(Uri.parse('$baseUrl/coming-soon'));
    if (response.statusCode == 200) {
      print('Coming Soon Response: ${response.body}');
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map((json) => Movie.fromJson(json)).toList();
    }
    throw Exception('Failed to load coming soon movies');
  }

  Future<Movie> getMovieDetail(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/movie?id=$id'));
    if (response.statusCode == 200) {
      print('Movie Detail Response: ${response.body}');
      final data = json.decode(response.body);
      return Movie.fromJson(data);
    }
    throw Exception('Failed to load movie detail');
  }
}
