import 'package:demo_movie_app/widgets/genres_list.dart';
import 'package:flutter/material.dart';

import 'package:demo_movie_app/bloc/get_genres_bloc.dart';
import 'package:demo_movie_app/model/genre.dart';
import 'package:demo_movie_app/model/genre_response.dart';

class Genres extends StatefulWidget {
  @override
  _GenresState createState() => _GenresState();
}

class _GenresState extends State<Genres> {
  @override
  void initState() {
    super.initState();
    genresBloc..getGenres();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GenreResponse>(
      stream: genresBloc.genresSubject.stream,
      builder: (context, AsyncSnapshot<GenreResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildError(snapshot.data.error);
          }
          return _buildGenres(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildError(snapshot.error);
        } else {
          return _buildLoading();
        }
      },
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 25.0,
            width: 25.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 4.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Error occured: $error'),
        ],
      ),
    );
  }

  Widget _buildGenres(GenreResponse data) {
    List<Genre> genres = data.genres;
    if (genres.length == 0) {
      return Container(
        child: Text('No Genres'),
      );
    } else {
      return GenresList(
        genres: genres,
      );
    }
  }
}
