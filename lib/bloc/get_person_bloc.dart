import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'package:demo_movie_app/model/person_response.dart';
import 'package:demo_movie_app/repository/movie_repository.dart';

class PersonListBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<PersonResponse> _personsSubject =
      BehaviorSubject<PersonResponse>();
  BehaviorSubject<PersonResponse> get personsSubject => _personsSubject;

  void getPersons() async {
    PersonResponse res = await _repository.getPersons();
    _personsSubject.sink.add(res);
  }

  void drainStream() {
    _personsSubject.value = null;
  }

  @mustCallSuper
  void dispose() async {
    await _personsSubject.drain();
    _personsSubject.close();
  }
}

final personListBloc = PersonListBloc();
