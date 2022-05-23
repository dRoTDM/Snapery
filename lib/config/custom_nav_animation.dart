import 'package:flutter/material.dart';

class SlideTransitionPageRoute extends PageRouteBuilder {
  final Widget child;
  final AxisDirection direction;
  final Duration animationDuration;

  SlideTransitionPageRoute({
    @required this.direction,
    @required this.child,
    @required this.animationDuration,
  }) : super(
          transitionDuration: animationDuration,
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      SlideTransition(
        position: Tween<Offset>(begin: getBeginOffset(), end: Offset.zero)
            .animate(animation),
        child: child,
      );

  Offset getBeginOffset() {
    Offset selectedOffset;
    switch (direction) {
      case AxisDirection.up:
        selectedOffset = const Offset(0, 1);
        break;
      case AxisDirection.down:
        selectedOffset = const Offset(0, -1);
        break;
      case AxisDirection.right:
        selectedOffset = const Offset(-1, 0);
        break;
      case AxisDirection.left:
        selectedOffset = const Offset(1, 0);
        break;
    }
    return selectedOffset;
  }
}

class BouncePageRoute extends PageRouteBuilder {
  final Widget child;
  final Duration animationDuration;
  final Alignment alignment;
  final Curve curve;

  BouncePageRoute({
    @required this.child,
    @required this.animationDuration,
    @required this.alignment,
    @required this.curve,
  }) : super(
          transitionDuration: animationDuration,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            animation = CurvedAnimation(parent: animation, curve: curve);
            return ScaleTransition(
              scale: animation,
              alignment: alignment,
              child: child,
            );
          },
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );
}
