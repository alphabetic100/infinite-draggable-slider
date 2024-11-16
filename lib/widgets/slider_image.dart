import 'package:flutter/material.dart';

class SliderImages extends StatelessWidget {
  const SliderImages({super.key, required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 250,
      decoration: BoxDecoration(),
    );
  }
}
