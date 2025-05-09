import 'package:dojo_flutter/core/interfaces/i_repository.dart';
import 'package:dojo_flutter/feature/camera/domain/entity/photo.dart';

abstract class IPhotoRepository extends IRepository {
  Future<void> savePhoto({required Photo photo});
  List<Photo> getPhotos();
}
