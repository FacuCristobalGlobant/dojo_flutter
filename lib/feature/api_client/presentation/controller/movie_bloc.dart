import 'package:dojo_flutter/core/interfaces/i_usecase.dart';
import 'package:dojo_flutter/feature/api_client/domain/entity/movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final IUseCase getMoviesUseCase;

  MovieBloc(
    this.getMoviesUseCase,
  ) : super(
          InitialMovieState(),
        ) {
    on<GetPopularMoviesCalled>(
      (event, emit) async {

        emit(LoadingMovieState());

        try {
          final movieList = await getMoviesUseCase.call();

          if (movieList.isEmpty) {
            emit(EmptyMovieState());
          } else {
            emit(
              OkMovieState(
                movies: movieList,
              ),
            );
          }
        } catch (e) {
          emit(ErrorMovieState());
        }
      },
    );
  }
}

sealed class MovieEvent {}

class GetPopularMoviesCalled extends MovieEvent {}

sealed class MovieState {
  const MovieState({
    this.movies,
  });

  final List<Movie>? movies;
}

class InitialMovieState extends MovieState {
  const InitialMovieState({
    super.movies,
  });
}

class LoadingMovieState extends MovieState {
  const LoadingMovieState({
    super.movies,
  });
}

class OkMovieState extends MovieState {
  const OkMovieState({
    required super.movies,
  });
}

class EmptyMovieState extends MovieState {
  const EmptyMovieState({
    super.movies,
  });
}

class ErrorMovieState extends MovieState {
  const ErrorMovieState({
    super.movies,
  });
}