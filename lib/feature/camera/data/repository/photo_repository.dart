import 'package:dojo_flutter/feature/camera/data/datasource/photo_datasource.dart';
import 'package:dojo_flutter/feature/camera/domain/entity/photo.dart';
import 'package:dojo_flutter/feature/camera/domain/repository/i_photo_repository.dart';

class PhotoRepository implements IPhotoRepository {
  PhotoRepository(this.photoDatasource);

  final PhotoDatasource photoDatasource;

  @override
  Future<void> savePhoto({required Photo photo}) async {
    await photoDatasource.savePhoto(photo: photo);
  }

  @override
  List<Photo> getPhotos() {
    final List<Photo> photos = photoDatasource.getPhotos();
    return photos;
  }
}
