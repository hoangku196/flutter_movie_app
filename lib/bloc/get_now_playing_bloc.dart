import 'package:demo_movie_app/model/movie_response.dart';
import 'package:demo_movie_app/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class NowPlayingMoviesListBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<MovieResponse> _movieSubject =
      BehaviorSubject<MovieResponse>();
  BehaviorSubject<MovieResponse> get movieSubject => _movieSubject;

  getPlayingMovies() async {
    MovieResponse res = await _repository.getPlayingMovies();
    _movieSubject.sink.add(res);
  }

  dispose() {
    _movieSubject.close();
  }
}

final nowPlayingMoviesBloc = NowPlayingMoviesListBloc();
