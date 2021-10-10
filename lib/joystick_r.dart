import 'dart:math';
import 'package:flutter/material.dart';

class JoystickRight extends StatefulWidget {
  final size_h;
  final Function get_data;
  const JoystickRight({Key? key, required this.size_h, required this.get_data})
      : super(key: key);

  @override
  _JoystickRightState createState() => _JoystickRightState();
}

class _JoystickRightState extends State<JoystickRight> {
  double right_dy = 0;
  double right_dx = 0;
  @override
  void initState() {
    right_dy = widget.size_h / 2;
    right_dx = widget.size_h / 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details) {
        setState(() {
          right_dy = details.localPosition.dy;
          right_dx = details.localPosition.dx;
          (right_dy <= 0) ? right_dy = 0 : 1;
          (right_dx <= 0) ? right_dx = 0 : 1;
          if (right_dy >= widget.size_h) {
            right_dy = widget.size_h;
          }
          if (right_dx >= widget.size_h) {
            right_dx = widget.size_h;
          }

          print(
              " dy = " + right_dy.toString() + "  dx = " + right_dx.toString());
        });
        widget.get_data(((right_dx * 100 ~/ widget.size_h) - 100).abs(),
            ((right_dy * 100 ~/ widget.size_h) - 100).abs());
      },
      onPanEnd: (DragEndDetails details) {
        setState(() {
          right_dy = widget.size_h / 2;
          right_dx = widget.size_h / 2;
          print(
              " dy = " + right_dy.toString() + "  dx = " + right_dx.toString());
        });
        widget.get_data(((right_dx * 100 ~/ widget.size_h) - 100).abs(),
            ((right_dy * 100 ~/ widget.size_h) - 100).abs());
      },
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
        width: widget.size_h,
        height: widget.size_h,
        child: CustomPaint(
          painter: LeftSwitch(right_dx, right_dy, widget.size_h),
        ),
      ),
    );
  }
}

class LeftSwitch extends CustomPainter {
  double dy = 0;
  double dx = 0;
  final size_h;
  LeftSwitch(this.dx, this.dy, this.size_h);

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final r_radius = sqrt(size_h * size_h * 2) / 10;
    var switch_paint = Paint()..color = Colors.red;
    var circle_paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = size_h / 100;
    var line_paint = Paint()
      ..color = Colors.white
      ..strokeWidth = size_h / 100;

    canvas.drawLine(Offset(size_h / 2, size_h / 2), Offset(dx, dy), line_paint);

    canvas.drawCircle(Offset(size_h / 2, size_h / 2), size_h / 2, circle_paint);
    canvas.drawCircle(Offset(dx, dy), r_radius, switch_paint); //switch
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
    throw UnimplementedError();
  }
}

// ------------------------------------------------------------------------------
