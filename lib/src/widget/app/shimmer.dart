import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zet_fire/src/colors/app_color.dart';

class CustomShimmer extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;
  final double verticalMargin;
  final double horizontalMargin;

  const CustomShimmer({
    Key? key,
    required this.height,
    required this.width,
    this.borderRadius = 0,
    this.horizontalMargin = 0,
    this.verticalMargin = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.shimmerBase,
      highlightColor: AppColor.shimmerHighlight,
      child: Container(
        width: width,
        height: height,
        margin: EdgeInsets.symmetric(horizontal: horizontalMargin, vertical: verticalMargin),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: AppColor.white,
        ),
      ),
    );
  }
}
