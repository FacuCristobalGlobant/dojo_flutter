// ignore_for_file: avoid_print

import 'dart:io';

import 'package:dojo_flutter/core/tools/cli_flag.dart';

void main(List<String> args) async {

  if (args.isEmpty) {
    print('''
Usage: dart core/tools/create_feature.dart [options]

Options:
  -n | --name <name of the feature>  

''');
    exit(0);
  }

  final String featuresRoot = './lib/feature';

  final CliFlag nameFlag = CliFlag(abbreviation: '-n', name: '--name');

  final String name = nameFlag.getValue(input: args).first;

  final featureDirectory = Directory('$featuresRoot/$name');
  var directoryExists = await featureDirectory.exists();

  if (directoryExists) {
    print('there is already a feature with that name');

    exit(0);
  }

  final dataRepository = await Directory('$featuresRoot/$name/data/repository').create(recursive: true);
  final datasourceRepository = await Directory('$featuresRoot/$name/data/datasource').create();
  final modelRepository = await Directory('$featuresRoot/$name/data/model').create();

  print('creating data layer...');
  print(dataRepository.path);
  print(datasourceRepository.path);
  print(modelRepository.path);
  print('');

  final entityDomain = await Directory('$featuresRoot/$name/domain/entity').create(recursive: true);
  final repositoryDomain = await Directory('$featuresRoot/$name/domain/repository').create();
  final usecaseDomain = await Directory('$featuresRoot/$name/domain/usecase').create();

  print('creating domain layer...');
  print(entityDomain.path);
  print(repositoryDomain.path);
  print(usecaseDomain.path);
  print('');

  final widget = await Directory('$featuresRoot/$name/presentation/widget').create(recursive: true);
  final controller = await Directory('$featuresRoot/$name/presentation/controller').create();
  final view = await Directory('$featuresRoot/$name/presentation/view').create();

  print('creating presentation layer...');
  print(widget.path);
  print(controller.path);
  print(view.path);
  print('');

  print('created $name feature folders');

  exit(0);
}
