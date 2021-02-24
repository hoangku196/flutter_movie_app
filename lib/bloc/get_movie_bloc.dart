import 'package:demo_movie_app/model/movie_response.dart';
import 'package:demo_movie_app/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesListBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<MovieResponse> _movieSubject =
      BehaviorSubject<MovieResponse>();
  BehaviorSubject<MovieResponse> get movieSubject => _movieSubject;

  getMovies() async {
    MovieResponse res = await _repository.getMovies();
    _movieSubject.sink.add(res);
  }

  dispose() {
    _movieSubject.close();
  }
}

final moviesBloc = MoviesListBloc();
