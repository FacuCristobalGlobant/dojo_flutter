import 'package:dojo_flutter/core/interfaces/i_usecase.dart';
import 'package:dojo_flutter/feature/camera/domain/entity/photo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final IUseCase savePhotoUseCase;
  final IUseCase getPhotosUseCase;

  PhotoBloc({
    required this.savePhotoUseCase,
    required this.getPhotosUseCase,
  }) : super(
          InitialPhotoState(),
        ) {
    on<SavePhotoEvent>(
      (event, emit) async {
        emit(LoadingPhotoState());

        try {
          savePhotoUseCase.call(
            args: {
              'photo': event.photo,
            },
          );
        } catch (e) {
          emit(ErrorPhotoState());
        }
      },
    );
    on<GetPhotosEvent>(
      (event, emit) async {
        emit(LoadingPhotoState());

        try {
          final List<Photo> photos = await getPhotosUseCase.call();

          emit(
            SuccessPhotoState(
              photos: photos,
            ),
          );
        } catch (e) {
          emit(ErrorPhotoState());
        }
      },
    );
  }
}

sealed class PhotoEvent {}

final class SavePhotoEvent extends PhotoEvent {
  SavePhotoEvent(this.photo);

  final Photo photo;
}

final class GetPhotosEvent extends PhotoEvent {}

sealed class PhotoState {
  const PhotoState({
    this.photos,
  });

  final List<Photo>? photos;
}

final class InitialPhotoState extends PhotoState {
  const InitialPhotoState({
    super.photos,
  });
}

final class LoadingPhotoState extends PhotoState {
  const LoadingPhotoState({
    super.photos,
  });
}

final class SuccessPhotoState extends PhotoState {
  const SuccessPhotoState({
    super.photos,
  });
}

final class ErrorPhotoState extends PhotoState {
  const ErrorPhotoState({
    super.photos,
  });
}
