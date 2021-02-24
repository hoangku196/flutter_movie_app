import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'package:demo_movie_app/bloc/get_movies_by_genres.dart';
import 'package:demo_movie_app/model/movie.dart';
import 'package:demo_movie_app/model/movie_response.dart';
import 'package:demo_movie_app/style/theme.dart' as Style;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class GenreMovie extends StatefulWidget {
  final int genreId;
  GenreMovie({this.genreId});
  @override
  _GenreMovieState createState() => _GenreMovieState(genreId);
}

class _GenreMovieState extends State<GenreMovie> {
  final int genreId;
  _GenreMovieState(this.genreId);

  @override
  void initState() {
    super.initState();
    moviesListByGenresBloc..getMoviesByGenres(genreId);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
      stream: moviesListByGenresBloc.movieSubject.stream,
      builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildError(snapshot.data.error);
          }
          return _buildMoviesByGenres(snapshot.data);
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

  Widget _buildMoviesByGenres(MovieResponse data) {
    List<Movie> movies = data.movies;
    if (movies.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('No Movies'),
          ],
        ),
      );
    } else {
      return Container(
        height: 270.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                top: 10.0,
                bottom: 10.0,
                right: 10.0,
              ),
              child: Column(
                children: [
                  Container(
                    width: 120.0,
                    height: 180.0,
                    decoration: BoxDecoration(
                      color: Style.Colors.secondColor,
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      shape: BoxShape.rectangle,
                    ),
                    child: Column(
                      children: [
                        Icon(
                          EvaIcons.filmOutline,
                          color: Colors.white,
                          size: 50.0,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 120.0,
                    height: 180.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        image: NetworkImage('https://image.tmbd.org/t/p/w200/' +
                            movies[index].poster),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: 100.0,
                    child: Text(
                      movies[index].title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        height: 1.4,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 11.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Text(
                        movies[index].rating.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      RatingBar.builder(
                        itemSize: 8.0,
                        initialRating: movies[index].rating / 2,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                        itemBuilder: (context, _) => Icon(
                          EvaIcons.star,
                          color: Style.Colors.secondColor,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
  }
}
