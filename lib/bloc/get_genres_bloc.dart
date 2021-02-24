import 'package:demo_movie_app/model/genre_response.dart';
import 'package:demo_movie_app/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class GenresListBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<GenreResponse> _genresSubject =
      BehaviorSubject<GenreResponse>();
  BehaviorSubject<GenreResponse> get genresSubject => _genresSubject;

  getGenres() async {
    GenreResponse res = await _repository.getGenres();
    _genresSubject.sink.add(res);
  }

  dispose() {
    _genresSubject.close();
  }
}

final genresBloc = GenresListBloc();
