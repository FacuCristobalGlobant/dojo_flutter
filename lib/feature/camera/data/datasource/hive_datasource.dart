import 'package:dojo_flutter/feature/camera/data/datasource/photo_datasource.dart';
import 'package:dojo_flutter/feature/camera/domain/entity/photo.dart';
import 'package:hive_ce/hive.dart';

class HiveDatasource extends PhotoDatasource{

  HiveDatasource(this.box);

  final Box<Photo> box;

  @override
  Future<void> savePhoto({required Photo photo}) async {
    await box.add(photo);
  }

  @override
  List<Photo> getPhotos() {
    final photos = box.values;
    return photos.toList();
  }
}
