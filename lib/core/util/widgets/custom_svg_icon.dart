import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvgIcon extends StatelessWidget {
  final String assetName;
  final Color? color;
  final double? size;
  final String? semanticsLabel;

  const CustomSvgIcon({
    super.key,
    required this.assetName,
    this.color,
    this.size,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      semanticsLabel: semanticsLabel,
      width: size,
      height: size,
      
    );
  }
}
