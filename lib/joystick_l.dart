import 'dart:math';
import 'package:flutter/material.dart';

class JoystickLeft extends StatefulWidget {
  final size_h;
  final Function get_data;
  const JoystickLeft({Key? key, required this.size_h, required this.get_data})
      : super(key: key);

  @override
  _JoystickLeftState createState() => _JoystickLeftState();
}

class _JoystickLeftState extends State<JoystickLeft> {
  double left_dy = 0;
  @override
  void initState() {
    left_dy = widget.size_h;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details) {
        setState(() {
          left_dy = details.localPosition.dy;
          (left_dy <= 0) ? left_dy = 0 : 1;
          if (left_dy >= widget.size_h) {
            left_dy = widget.size_h;
          }
          print(" left_dy = " + left_dy.toString());
          widget.get_data(((left_dy * 100 ~/ widget.size_h) - 100).abs());
        });
      },
      child: Container(
        decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
        width: widget.size_h,
        height: widget.size_h,
        child: CustomPaint(
          painter: LeftSwitch(left_dy, widget.size_h),
        ),
      ),
    );
  }
}

class LeftSwitch extends CustomPainter {
  double dy = 0;
  final size_h;
  LeftSwitch(this.dy, this.size_h);

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final l_radius = sqrt(size_h * size_h * 2) / 10;
    var switch_paint = Paint()..color = Colors.red;
    var circle_paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = size_h / 100;
    var line_paint = Paint()
      ..color = Colors.white
      ..strokeWidth = size_h / 100;
    canvas.drawLine(Offset(size_h / 2 - l_radius, size_h / 2),
        Offset(size_h / 2 - l_radius, dy), line_paint);

    canvas.drawLine(Offset(size_h / 2 + l_radius, size_h / 2),
        Offset(size_h / 2 + l_radius, dy), line_paint);

    canvas.drawCircle(Offset(size_h / 2, size_h / 2), size_h / 2, circle_paint);
    canvas.drawCircle(Offset(size_h / 2, dy), l_radius, switch_paint); //switch
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
    throw UnimplementedError();
  }
}

// ------------------------------------------------------------------------------
