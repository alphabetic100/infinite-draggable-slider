library animated_slider;

import 'package:animated_slider/widgets/slider_image.dart';
import 'package:flutter/material.dart';

class AnimatedSlider extends StatelessWidget {
  const AnimatedSlider({
    super.key,
    required this.imageList,
    this.heinght,
    this.width,
    this.alignment,
    this.onTap,
  });
  final List imageList;
  final double? heinght;
  final double? width;
  final Alignment? alignment;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: List.generate(4, (index) {
      return SliderImages(image: imageList[index]);
    }));
  }
}
