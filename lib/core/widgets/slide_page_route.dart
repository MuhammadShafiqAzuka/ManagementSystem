import 'package:flutter/material.dart';

class SlidePageRoute extends PageRouteBuilder {
  final Widget page;
  final AxisDirection direction;

  SlidePageRoute({required this.page, this.direction = AxisDirection.right})
      : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      Offset begin;
      switch (direction) {
        case AxisDirection.up:
          begin = const Offset(0, 1);
          break;
        case AxisDirection.down:
          begin = const Offset(0, -1);
          break;
        case AxisDirection.left:
          begin = const Offset(-1, 0);
          break;
        case AxisDirection.right:
        begin = const Offset(1, 0);
      }

      const end = Offset.zero;
      const curve = Curves.ease;

      final tween = Tween(begin: begin, end: end)
          .chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}