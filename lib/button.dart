import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  const Button({Key? key}) : super(key: key);
  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> curve;
  final _duration = const Duration(seconds: 1);
  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: _duration);
    curve = controller.drive(CurveTween(curve: Curves.fastOutSlowIn));
    super.initState();
  }

  void _handleTapDown(TapDownDetails details) {
    if (controller.status != AnimationStatus.completed) {
      controller.forward();
    }
  }

  void _handleTapCancel() {
    if (controller.status != AnimationStatus.completed) {
      controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      return GestureDetector(
        onTapCancel: _handleTapCancel,
        onTapDown: _handleTapDown,
        onDoubleTap: () => controller.reset(),
        child: AnimatedBuilder(
            animation: curve,
            builder: (context, _) {
              return AspectRatio(
                aspectRatio: 1.0,
                child: CustomPaint(
                  painter: ButtonPainter(progress: curve.value),
                ),
              );
            }),
      );
    });
  }
}

class ButtonPainter extends CustomPainter {
  final double progress;
  ButtonPainter({required this.progress});
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final stroke = size.width / 12.0;
    final radius = (size.width - stroke) / 2;
    final background = Paint()
      ..isAntiAlias = true
      ..color = Colors.redAccent
      ..strokeWidth = stroke
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, background);

    final foreground = Paint()
      ..isAntiAlias = true
      ..color = Colors.white
      ..strokeWidth = stroke
      ..style = PaintingStyle.stroke;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      foreground,
    );
  }

  @override
  bool shouldRepaint(covariant ButtonPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
