import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:dojo_flutter/constants/constants.dart';
import 'package:dojo_flutter/models/models.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    required this.movie,
    this.radius = Measures.small,
  });

  final Movie movie;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Measures.medium),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(
                Measures.small,
                Measures.small,
              ),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: Measures.cardImageHeight,
                  width: Measures.cardImageWidth,
                  child: CachedNetworkImage(
                    errorWidget: (context, url, error) => SizedBox(
                      height: Measures.cardImageHeight,
                      width: Measures.cardImageWidth,
                      child: Center(
                        child: Icon(
                          Icons.error_outline,
                          size: Measures.xxLarge,
                        ),
                      ),
                    ),
                    imageUrl: '${ApiConstants.baseImageW500}${movie.posterPath}',
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        SizedBox(
                      height: Measures.cardImageHeight,
                      width: Measures.cardImageWidth,
                      child: Center(
                        child: CircularProgressIndicator(
                          value: downloadProgress.progress,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Measures.xSmall,
                    horizontal: Measures.large,
                  ),
                  child: SizedBox(
                    width: Measures.cardImageWidth - (Measures.large * 2),
                    child: Text(
                      movie.title!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Measures.large,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Measures.large,
                  ),
                  child: Text(
                    movie.releaseDate!,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
