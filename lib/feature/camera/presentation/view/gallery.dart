import 'dart:convert';

import 'package:dojo_flutter/constants/constants.dart';
import 'package:dojo_flutter/constants/routes.dart';
import 'package:dojo_flutter/constants/string_constants.dart';
import 'package:dojo_flutter/feature/camera/presentation/controller/photo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GalleryView extends StatefulWidget {
  const GalleryView({super.key});

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  late final PhotoBloc photoBloc;

  @override
  void initState() {
    super.initState();
    photoBloc = context.read<PhotoBloc>();
    photoBloc.add(GetPhotosEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => context.go(Routes.home),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            StringConstants.gallery,
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        body: BlocBuilder<PhotoBloc, PhotoState>(
          builder: (
            BuildContext context,
            PhotoState state,
          ) {
            if (state is LoadingPhotoState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SuccessPhotoState) {
              final List<Widget> photoWidgets = state.photos!.map(
                (photo) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width / 4.5,
                    child: ColoredBox(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: Measures.xSmall,
                          left: Measures.xSmall,
                          right: Measures.xSmall,
                          bottom: Measures.xxLarge,
                        ),
                        child: Image.memory(base64Decode(photo.imageData)),
                      ),
                    ),
                  );
                },
              ).toList();
              return Padding(
                padding: const EdgeInsets.all(Measures.large),
                child: Expanded(
                  child: Wrap(
                    alignment: WrapAlignment.spaceAround,
                    spacing: Measures.large,
                    children: photoWidgets,
                  ),
                ),
              );
            }

            return Center();
          },
        ),
      ),
    );
  }
}
