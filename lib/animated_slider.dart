library animated_slider;

import 'dart:math';
import 'dart:ui';
import 'package:animated_slider/widgets/draggable_widget.dart';
import 'package:flutter/material.dart';

class AnimatedSlider extends StatefulWidget {
  const AnimatedSlider({
    super.key,
    this.heinght,
    this.width,
    this.padding,
    this.onTap,
    required this.itemCount,
    required this.itemBuielder,
    this.index = 0,
  });

  final double? heinght;
  final double? width;
  final EdgeInsets? padding;
  final Function? onTap;
  final Function(BuildContext context, int index) itemBuielder;
  final int itemCount;
  final int index;

  @override
  State<AnimatedSlider> createState() => _AnimatedSliderState();
}

class _AnimatedSliderState extends State<AnimatedSlider>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  SliderDirection sliderDirection = SliderDirection.left;

  late int index;
  double defaultAngle = pi * 0.1;
  Offset getOffset(int stackIndex) =>
      {
        0: Offset(lerpDouble(0, -70, controller.value)!, 30),
        1: Offset(lerpDouble(-70, 70, controller.value)!, 30),
        2: const Offset(70, 30) * (1 - controller.value),
      }[stackIndex] ??
      Offset(
          MediaQuery.of(context).size.width *
              controller.value *
              (sliderDirection == SliderDirection.left ? -1 : 1),
          0);

  double getAngle(int stackIndex) =>
      {
        0: lerpDouble(0, -defaultAngle, controller.value),
        1: lerpDouble(-defaultAngle, defaultAngle, controller.value),
        2: lerpDouble(defaultAngle, 0, controller.value),
      }[stackIndex] ??
      0.0;
  double getScale(int stackIndex) =>
      {
        0: lerpDouble(0.6, 0.9, controller.value),
        1: lerpDouble(0.9, 0.95, controller.value),
        2: lerpDouble(0.95, 1, controller.value),
      }[stackIndex] ??
      1.0;
  void onSliderOut(SliderDirection direction) {
    sliderDirection = direction;
    controller.forward();
  }

  void animationListener() {
    if (controller.isCompleted) {
      setState(() {
        if (widget.itemCount == ++index) {
          index == 0;
        }
      });
      controller.reset();
    }
  }

  @override
  void initState() {
    index = widget.index;
    controller =
        AnimationController(vsync: this, duration: kThemeAnimationDuration)
          ..addListener(animationListener);
    super.initState();
  }

  @override
  void dispose() {
    controller
      ..addListener(animationListener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          return SizedBox(
            height: widget.heinght,
            width: widget.width,
            child: Padding(
              padding: widget.padding?? const EdgeInsets.all(0.8),
              child: Stack(
                  children: List.generate(4, (stackIndex) {
                final modIndex = (index + 3 - stackIndex) % widget.itemCount;
                return Transform.translate(
                  offset: getOffset(stackIndex),
                  child: Transform.scale(
                    scale: getScale(stackIndex),
                    child: Transform.rotate(
                      angle: getAngle(stackIndex),
                      child: DraggableWidget(
                          onSliderOut: onSliderOut,
                          child: widget.itemBuielder(context, modIndex),
                          isEnableDrag: stackIndex == 3),
                    ),
                  ),
                );
              })),
            ),
          );
        });
  }
}
