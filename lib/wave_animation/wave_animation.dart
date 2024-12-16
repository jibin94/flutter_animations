import 'package:flutter/material.dart';

import 'wave_clippath.dart';

class WaveAnimation extends StatefulWidget {
  const WaveAnimation({super.key});

  @override
  WaveAnimationState createState() => WaveAnimationState();
}

class WaveAnimationState extends State<WaveAnimation>
    with SingleTickerProviderStateMixin {
  late Animation<double> horizontalAnimation;
  late Animation<double> verticalAnimation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 6), // Full cycle duration
      vsync: this,
    )..repeat();

    // Horizontal wave animation
    horizontalAnimation = Tween<double>(begin: -500, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    // Vertical up-and-down animation with pauses and filling effect
    verticalAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 150.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: ConstantTween(150), // Pause at the top
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 150.0, end: 0.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: ConstantTween(0), // Pause at the bottom
        weight: 1,
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: MyClipPath(horizontalAnimation, verticalAnimation),
    );
  }
}
