import 'package:demo_movie_app/model/genre_response.dart';
import 'package:demo_movie_app/model/person_response.dart';
import 'package:dio/dio.dart';
import 'package:demo_movie_app/model/movie_response.dart';

class MovieRepository {
  final String apiKey = '72a135bea4ee59989bf68f59ac5a3c84';
  static String mainUrl = 'https://api.themoviedb.org/3';
  final Dio _dio = Dio();

  var getPopularUrl = '$mainUrl/movie/top_rated';
  var getMovieUrl = '$mainUrl/discover/movie';
  var getPlayingUrl = '$mainUrl/movie/now_playing';
  var getGenresUrl = '$mainUrl/genre/movie/list';
  var getPersonsUrl = '$mainUrl/trending/person/week';

  Future<MovieResponse> getMovies() async {
    var params = {'api_key': apiKey, 'language': 'en-US', 'page': 1};
    try {
      Response res = await _dio.get(
        getPopularUrl,
        queryParameters: params,
      );
      return MovieResponse.fromJson(res.data);
    } catch (error, stackTrace) {
      print('Exception occured: $error stackTrace: $stackTrace');
      return MovieResponse.withError('$error');
    }
  }

  Future<MovieResponse> getPlayingMovies() async {
    var params = {'api_key': apiKey, 'language': 'en-US', 'page': 1};

    try {
      Response res = await _dio.get(getPlayingUrl, queryParameters: params);
      return MovieResponse.fromJson(res.data);
    } catch (error, stackTrace) {
      print('Exception occured: $error stackTrace: $stackTrace');
      return MovieResponse.withError('$error');
    }
  }

  Future<GenreResponse> getGenres() async {
    var params = {'api_key': apiKey, 'language': 'en-US', 'page': 1};

    try {
      Response res = await _dio.get(getGenresUrl, queryParameters: params);
      return GenreResponse.fromJson(res.data);
    } catch (error, stackTrace) {
      print('Exception occured: $error stackTrace: $stackTrace');
      return GenreResponse.withError('$error');
    }
  }

  Future<PersonResponse> getPersons() async {
    var params = {'api_key': apiKey};

    try {
      Response res = await _dio.get(getPersonsUrl, queryParameters: params);
      return PersonResponse.fromJson(res.data);
    } catch (error, stackTrace) {
      print('Exception occured: $error stackTrace: $stackTrace');
      return PersonResponse.withError('$error');
    }
  }

  Future<MovieResponse> getMovieByGenres(int id) async {
    var params = {
      'api_key': apiKey,
      'language': 'en-US',
      'page': 1,
      'with_genres': id
    };

    try {
      Response res = await _dio.get(getGenresUrl, queryParameters: params);
      return MovieResponse.fromJson(res.data);
    } catch (error, stackTrace) {
      print('Exception occured: $error stackTrace: $stackTrace');
      return MovieResponse.withError('$error');
    }
  }
}
