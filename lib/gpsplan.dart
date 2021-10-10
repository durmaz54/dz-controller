import 'package:flutter/material.dart';

class GpsPlan extends StatefulWidget {
  final double width;
  final double height;
  const GpsPlan({Key? key, required this.width, required this.height})
      : super(key: key);

  @override
  _GpsPlanState createState() => _GpsPlanState();
}

class _GpsPlanState extends State<GpsPlan> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      color: Colors.green,
    );
  }
}
