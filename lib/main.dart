import 'package:camera/camera.dart';
import 'package:dojo_flutter/constants/constants.dart';
import 'package:dojo_flutter/constants/routes.dart';
import 'package:dojo_flutter/feature/api_client/data/datasource/api_data_source.dart';
import 'package:dojo_flutter/feature/api_client/data/repository/api_movie_repository.dart';
import 'package:dojo_flutter/feature/api_client/domain/usecase/get_movies_usecase.dart';
import 'package:dojo_flutter/feature/api_client/presentation/controller/movie_bloc.dart';
import 'package:dojo_flutter/feature/auth/presentation/controller/authentication_bloc.dart';
import 'package:dojo_flutter/feature/auth/presentation/controller/stream_to_listenable.dart';
import 'package:dojo_flutter/feature/auth/presentation/view/login_view.dart';
import 'package:dojo_flutter/feature/camera/data/datasource/hive_boxes.dart';
import 'package:dojo_flutter/feature/camera/data/datasource/hive_datasource.dart';
import 'package:dojo_flutter/feature/camera/data/datasource/hive_registrar.g.dart';
import 'package:dojo_flutter/feature/camera/data/repository/photo_repository.dart';
import 'package:dojo_flutter/feature/camera/domain/entity/photo.dart';
import 'package:dojo_flutter/feature/camera/domain/usecase/get_photos_usecase.dart';
import 'package:dojo_flutter/feature/camera/domain/usecase/save_photo_usecase.dart';
import 'package:dojo_flutter/feature/camera/presentation/controller/photo_bloc.dart';
import 'package:dojo_flutter/feature/camera/presentation/view/camera_view.dart';
import 'package:dojo_flutter/feature/camera/presentation/view/gallery.dart';
import 'package:dojo_flutter/feature/local_database/data/datasource/sqlite_database_proxy.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:dojo_flutter/feature/api_client/presentation/pages/home_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:go_router/go_router.dart';

late final Box<Photo> photoBox;

final _router = GoRouter(
  refreshListenable:
      StreamToListenable(FirebaseAuth.instance.authStateChanges()),
  redirect: (BuildContext context, GoRouterState state) {
    final isAuthenticated = FirebaseAuth.instance.currentUser != null;

    // Redirect to the login page if the user is not authenticated, and if authenticated, do not show the login page
    if (!isAuthenticated && !state.matchedLocation.contains(Routes.login)) {
      return Routes.login;
    }
    // Redirect to the home page if the user is authenticated
    else if (isAuthenticated && state.matchedLocation.contains(Routes.login)) {
      return Routes.home;
    }
    return null;
  },
  routes: [
    GoRoute(
      path: Routes.login,
      builder: (context, state) => MultiProvider(
        providers: [
          Provider(
            create: (_) => AuthenticationBloc(),
          ),
        ],
        child: LoginView(),
      ),
    ),
    GoRoute(
      path: Routes.logout,
      redirect: (BuildContext context, GoRouterState state) {
        FirebaseAuth.instance.signOut();
        return Routes.login;
      },
    ),
    GoRoute(
      path: Routes.home,
      builder: (context, state) => MultiProvider(
        providers: [
          Provider<ApiDataSource>(create: (_) => ApiDataSource()),
          Provider<SqlDatabaseProxy>(create: (_) => SqlDatabaseProxy()),
          ProxyProvider2<ApiDataSource, SqlDatabaseProxy, ApiMovieRepository>(
            update: (_, apiDataSource, sqlDatabaseDataSource, __) =>
                ApiMovieRepository(
              mainDataSource: apiDataSource,
              localDatabase: sqlDatabaseDataSource,
            ),
          ),
          ProxyProvider<ApiMovieRepository, GetMoviesUseCase>(
            update: (_, apiMovieRepository, __) => GetMoviesUseCase(
              apiMovieRepository,
            ),
          ),
          ProxyProvider<GetMoviesUseCase, MovieBloc>(
            update: (_, useCase, __) => MovieBloc(useCase),
          ),
        ],
        child: const HomePage(),
      ),
    ),
    GoRoute(
      path: Routes.camera,
      builder: (context, state) => MultiProvider(
        providers: [
          Provider<Box<Photo>>(create: (_) => photoBox),
          ProxyProvider<Box<Photo>, HiveDatasource>(
            update: (_, photoBox, __) => HiveDatasource(photoBox),
          ),
          ProxyProvider<HiveDatasource, PhotoRepository>(
            update: (_, photoDatasource, __) =>
                PhotoRepository(photoDatasource),
          ),
          ProxyProvider<PhotoRepository, SavePhotoUseCase>(
            update: (_, repository, __) => SavePhotoUseCase(repository),
          ),
          ProxyProvider<PhotoRepository, GetPhotosUseCase>(
            update: (_, repository, __) => GetPhotosUseCase(repository),
          ),
          ProxyProvider2<SavePhotoUseCase, GetPhotosUseCase, PhotoBloc>(
            update: (_, savePhotoUseCase, getPhotosUseCase, __) => PhotoBloc(
              savePhotoUseCase: savePhotoUseCase,
              getPhotosUseCase: getPhotosUseCase,
            ),
          ),
        ],
        child: const CameraView(),
      ),
    ),
    GoRoute(
      path: Routes.gallery,
      builder: (context, state) => MultiProvider(
        providers: [
          Provider<Box<Photo>>(create: (_) => photoBox),
          ProxyProvider<Box<Photo>, HiveDatasource>(
            update: (_, photoBox, __) => HiveDatasource(photoBox),
          ),
          ProxyProvider<HiveDatasource, PhotoRepository>(
            update: (_, photoDatasource, __) =>
                PhotoRepository(photoDatasource),
          ),
          ProxyProvider<PhotoRepository, SavePhotoUseCase>(
            update: (_, repository, __) => SavePhotoUseCase(repository),
          ),
          ProxyProvider<PhotoRepository, GetPhotosUseCase>(
            update: (_, repository, __) => GetPhotosUseCase(repository),
          ),
          ProxyProvider2<SavePhotoUseCase, GetPhotosUseCase, PhotoBloc>(
            update: (_, savePhotoUseCase, getPhotosUseCase, __) => PhotoBloc(
              savePhotoUseCase: savePhotoUseCase,
              getPhotosUseCase: getPhotosUseCase,
            ),
          ),
        ],
        child: const GalleryView(),
      ),
    ),
  ],
);

void _logError(String? message) {
  // ignore: avoid_print
  print('Error: ${message == null ? '' : '\nError Message: $message'}');
}

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapters();
  photoBox = await Hive.openBox<Photo>(HiveBoxes.photoBox);

  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    _logError(e.toString());
  }
  runApp(TmdbApp());
}

class TmdbApp extends StatelessWidget {
  const TmdbApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: ThemeConstants.primaryColor,
          primary: ThemeConstants.primaryColor,
        ),
        useMaterial3: true,
      ),
    );
  }
}
