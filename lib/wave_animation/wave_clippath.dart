import 'package:flutter/material.dart';
import 'package:flutter_animations/wave_animation/wave_clipper.dart';

class MyClipPath extends AnimatedWidget {
  final Animation<double> horizontalAnimation;
  final Animation<double> verticalAnimation;

  MyClipPath(this.horizontalAnimation, this.verticalAnimation, {super.key})
      : super(
          listenable: Listenable.merge(
            [horizontalAnimation, verticalAnimation],
          ),
        );

  final Color backgroundColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        const Text(
          'Wave Animation',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.0),
        ),
        Expanded(
          child: Stack(
            children: [
              // Background to show the "filling" effect
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.9),
                      border: Border.all(
                        width: 0,
                        color: Colors.blue.withOpacity(0.7),
                      ),
                    ),
                    width: double.infinity,
                    height: verticalAnimation.value,
                  ),
                ),
              ),
              // First wave
              Positioned(
                bottom: verticalAnimation.value,
                right: horizontalAnimation.value,
                child: ClipPath(
                  clipper: BottomWaveClipper(),
                  child: Opacity(
                    opacity: 0.7,
                    child: Container(
                      color: backgroundColor,
                      width: 1000,
                      height: 200,
                    ),
                  ),
                ),
              ),
              // Second wave (mirrored for more realism)
              Positioned(
                bottom: verticalAnimation.value,
                left: horizontalAnimation.value,
                child: ClipPath(
                  clipper: BottomWaveClipper(),
                  child: Opacity(
                    opacity: 0.7,
                    child: Container(
                      color: backgroundColor,
                      width: 1000,
                      height: 200,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/*
Key Factors:
  1.Opposite Directions of the Waves:
    One wave uses right: horizontalAnimation.value.
    The other wave uses left: horizontalAnimation.value.
    This makes them move in opposite directions horizontally, simulating a rolling or "interference" effect between the waves.

  2.Transparency (Opacity) and Layering:
    Both waves have opacity: 0.7, making them semi-transparent. This allows the waves to blend visually instead of fully blocking each other.
    The stacking of the two waves, combined with their movement in opposite directions, gives the appearance of depth and motion.

   3.Symmetry in the BottomWaveClipper:
    The BottomWaveClipper ensures that both waves have a similar but mirrored shape.
    This symmetry contributes to the natural look of the waves when combined.

  4.Vertical Alignment:
    Both waves are positioned at bottom: verticalAnimation.value.
    This keeps them aligned vertically, reinforcing the visual effect that they belong to the same body of water.
*/
