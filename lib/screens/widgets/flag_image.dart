import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FlagImage extends StatelessWidget {
  final String imgSrc;

  const FlagImage({
    Key? key,
    required this.imgSrc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (imgSrc.endsWith('png')) {
      child = Image.network(imgSrc);
    }
    child = SvgPicture.network(imgSrc);

    return Expanded(
      child: child,
    );
  }
}
