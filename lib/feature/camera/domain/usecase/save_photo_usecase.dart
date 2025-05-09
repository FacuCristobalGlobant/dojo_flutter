import 'package:dojo_flutter/core/interfaces/i_usecase.dart';
import 'package:dojo_flutter/feature/camera/domain/repository/i_photo_repository.dart';

class SavePhotoUseCase implements IUseCase<void> {
  final IPhotoRepository repository;

  SavePhotoUseCase(this.repository);

  @override
  Future<void> call({Map<String, dynamic>? args}) async {
    return repository.savePhoto(photo: args?['photo']);
  }
}
