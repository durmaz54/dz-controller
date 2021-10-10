import 'package:flutter/material.dart';

class Terminal extends StatefulWidget {
  final double size_w;
  final double size_h;
  final List<String> message;
  const Terminal(
      {Key? key,
      required this.size_w,
      required this.size_h,
      required this.message})
      : super(key: key);
  @override
  _TerminalState createState() => _TerminalState();
}

class _TerminalState extends State<Terminal> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.size_h,
        width: widget.size_w,
        color: Colors.black54,
        child: ListView.builder(
          itemCount: widget.message.length,
          itemBuilder: (BuildContext context, int index) {
            return Text(widget.message[index]);
          },
        ));
  }
}
