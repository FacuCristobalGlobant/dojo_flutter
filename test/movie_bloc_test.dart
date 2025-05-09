import 'package:bloc_test/bloc_test.dart';
import 'package:dojo_flutter/feature/api_client/domain/entity/movie.dart';
import 'package:dojo_flutter/feature/api_client/domain/usecase/get_movies_usecase.dart';
import 'package:dojo_flutter/feature/api_client/presentation/controller/movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mock_data/movie_mock.dart';
@GenerateNiceMocks([MockSpec<GetMoviesUseCase>()])
import 'movie_bloc_test.mocks.dart';

void main() {
  test(
    'Empty movie bloc state',
    () async* {
      final getMoviesUseCaseMock = MockGetMoviesUseCase();

      final movieBloc = MovieBloc(getMoviesUseCaseMock);
      final stream = movieBloc.stream;

      when(getMoviesUseCaseMock.call()).thenAnswer((_) async => <Movie>[]);

      movieBloc.add(GetPopularMoviesCalled());

      expect(
        stream,
        emitsInOrder(
          [
            LoadingMovieState(),
            EmptyMovieState(),
          ],
        ),
      );
    },
  );

  test(
    'Movie bloc state with results',
    () async* {
      final getMoviesUseCaseMock = MockGetMoviesUseCase();

      final movieBloc = MovieBloc(getMoviesUseCaseMock);
      final stream = movieBloc.stream;

      when(getMoviesUseCaseMock.call()).thenAnswer(
        (_) async => <Movie>[
          MovieMock.mockedMovie,
        ],
      );

      movieBloc.add(
        GetPopularMoviesCalled(),
      );

      expect(
        stream,
        emitsInOrder(
          [
            LoadingMovieState(),
            OkMovieState(movies: [
              MovieMock.mockedMovie,
            ]),
          ],
        ),
      );
    },
  );
  group(MovieBloc, () {
    late MovieBloc movieBloc;
    final getMoviesUseCaseMock = MockGetMoviesUseCase();

    setUp(() {
      movieBloc = MovieBloc(getMoviesUseCaseMock);
    });
    test('initial state', () {
      expect(movieBloc.state.runtimeType, InitialMovieState);
    });
    blocTest(
      'emits EmptyMovieState when GetPopularMoviesCalled is added',
      build: () => movieBloc,
      act: (bloc) => bloc.add(GetPopularMoviesCalled()),
      expect: () => [isA<LoadingMovieState>(), isA<EmptyMovieState>()],
    );
    blocTest(
      'emits OkMovieState when GetPopularMoviesCalled is added',
      build: () => movieBloc,
      setUp: () {
        when(getMoviesUseCaseMock.call()).thenAnswer(
          (_) async => <Movie>[
            MovieMock.mockedMovie,
          ],
        );
      },
      act: (bloc) => bloc.add(GetPopularMoviesCalled()),
      expect: () => [isA<LoadingMovieState>(), isA<OkMovieState>()],
    );
    blocTest(
      'emits ErrorMovieState when usecase throws an error',
      build: () => movieBloc,
      setUp: () {
        when(getMoviesUseCaseMock.call()).thenThrow(Exception());
      },
      act: (bloc) => bloc.add(GetPopularMoviesCalled()),
      expect: () => [isA<LoadingMovieState>(), isA<ErrorMovieState>()],
    );
  });
}
