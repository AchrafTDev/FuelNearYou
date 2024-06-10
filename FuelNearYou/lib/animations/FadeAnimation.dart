import 'package:flutter/material.dart';
import 'package:simple_animations/multi_tween/multi_tween.dart';
import 'package:simple_animations/stateless_animation/play_animation.dart';

enum Props { opacity, translatey }

class FadeAnimation extends StatelessWidget {
  // This class is mainly for the fading animation from top to bottom
  // simple_animations dependency is used
  final double delay;
  final Widget child;

// Setting the delay animation begin and end time
// Setting animation into 500 miliseconds delay
  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<Props>()
      ..add(Props.opacity, Tween(begin: 0.0, end: 1.0))
      ..add(Props.translatey,Tween(begin: -130.0, end: 0.0),
          Duration(milliseconds: 500),
          Curves.easeOut);

    return PlayAnimation<MultiTweenValues<Props>>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, child, animation) => Opacity(
        opacity: animation.get(Props.opacity),
        child: Transform.translate(
            offset: Offset(0, animation.get(Props.translatey)),
            child: child
      ),
    ),
  );

  }
}
