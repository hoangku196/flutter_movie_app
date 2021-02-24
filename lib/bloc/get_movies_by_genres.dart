import 'package:demo_movie_app/model/movie_response.dart';
import 'package:demo_movie_app/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesListByGenresBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<MovieResponse> _movieSubject =
      BehaviorSubject<MovieResponse>();
  BehaviorSubject<MovieResponse> get movieSubject => _movieSubject;

  getMoviesByGenres(int id) async {
    MovieResponse res = await _repository.getMovieByGenres(id);
    _movieSubject.sink.add(res);
  }

  void drainStream() {
    _movieSubject.value = null;
  }

  dispose() {
    _movieSubject.close();
  }
}

final moviesListByGenresBloc = MoviesListByGenresBloc();
