import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ShakeTransition extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final double offset;
  final Axis axis;

  const ShakeTransition(
      {Key key,
      this.axis = Axis.horizontal,
      this.offset = 140,
      this.duration = const Duration(milliseconds: 900),
      @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      child: child,
      duration: duration,
      curve: Curves.elasticOut,
      tween: Tween(begin: 1.0, end: 0.0),
      builder: (context, value, child) {
        return Transform.translate(
            offset: axis == Axis.horizontal
                ? Offset(value * offset, 0.0)
                : Offset(0.0, value * offset),
            child: child);
      },
    );
  }
}
