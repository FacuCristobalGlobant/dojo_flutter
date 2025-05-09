import 'package:dojo_flutter/feature/camera/domain/entity/photo.dart';

abstract class PhotoDatasource {
  Future<void> savePhoto({required Photo photo});
  List<Photo> getPhotos();
}
