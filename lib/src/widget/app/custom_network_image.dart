import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String image;
  final BoxFit boxFit;
  final double? width;
  final double? height;
  final BorderRadius borderRadius;
  final Function()? onTap;

  const CustomNetworkImage({
    Key? key,
    required this.image,
    this.boxFit = BoxFit.cover,
    this.width,
    this.height,
    this.borderRadius = BorderRadius.zero,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: CachedNetworkImage(
          height: height,
          width: width,
          imageUrl: image,
          placeholder: (context, url) => const SizedBox(
            height: 56,
            width: 56,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: boxFit,
        ),
      ),
    );
  }
}
