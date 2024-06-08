import 'package:dart_plus_app/data/connection_status.dart';
import 'package:dart_plus_app/data/dao/popular_movies_dao.dart';
import 'package:dart_plus_app/data/repositories/movie_repository_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/interfaces/models/popular_movies.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {

  //todo adicionar estrutura de injeção de dependências para o Repository e o Dao

  final _movieRepository = MovieRepositoryImpl();
  final dbRepository = PopularMoviesDao();

  PopularMoviesBloc() : super(MoviesInitial()) {
    on<PopularMoviesEvent>((event, emit) async {
      if (event is GetAllPopularMovies) {
        emit(const PopularMoviesLoading());
        try {
          List<PopularMovie> movies;
          if (await isConnectedToInternet()) {
            movies = await _movieRepository.getAllPopularMovies();
          } else {
            movies = await dbRepository.readPopularMovies();
          }
          emit(PopularMoviesLoaded(movies));
        } catch (_) {
          emit(const PopularMoviesError());
        }
      }
    });
  }
}
