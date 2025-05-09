import 'package:dojo_flutter/core/interfaces/i_usecase.dart';
import 'package:dojo_flutter/feature/camera/domain/entity/photo.dart';
import 'package:dojo_flutter/feature/camera/domain/repository/i_photo_repository.dart';

class GetPhotosUseCase implements IUseCase<void>{

  final IPhotoRepository repository;

  GetPhotosUseCase(this.repository);

  @override
  Future<List<Photo>> call({Map<String, dynamic>? args}) async {
    return repository.getPhotos();
  }

}