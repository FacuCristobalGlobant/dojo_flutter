import 'package:dojo_flutter/feature/camera/domain/entity/photo.dart';
import 'package:hive_ce/hive.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([
  AdapterSpec<Photo>(),
])
class HiveAdapters {}
