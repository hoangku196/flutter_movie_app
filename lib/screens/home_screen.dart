import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'package:demo_movie_app/style/theme.dart' as Style;
import 'package:demo_movie_app/widgets/genres.dart';
import 'package:demo_movie_app/widgets/now_playing.dart';
import 'package:demo_movie_app/widgets/person.dart';
import 'package:demo_movie_app/widgets/top_movies.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        centerTitle: true,
        leading: Icon(
          EvaIcons.menu2Outline,
          color: Colors.white,
        ),
        title: Text('Movie App'),
        actions: [
          IconButton(
            icon: Icon(
              EvaIcons.searchOutline,
              color: Colors.white,
            ),
            onPressed: () {
              print('null');
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          NowPlaying(),
          Genres(),
          Person(),
          TopMovies(),
          
        ],
      ),
    );
  }
}
