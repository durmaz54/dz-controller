import 'dart:typed_data';

import 'package:dz_plane/terminal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'joystick_l.dart';
import 'joystick_r.dart';
import 'package:dz_plane/ble_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
      .then((_) {
    runApp(ChangeNotifierProvider<BleData>(
      child: MyApp(),
      create: (BuildContext context) {
        return BleData();
      },
    ));
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: BleMenu()),
      body: BodyBar(),
    );
  }
}

class BodyBar extends StatelessWidget {
  const BodyBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    Function getLeft = Provider.of<BleData>(context).getLeft;
    Function getRight = Provider.of<BleData>(context).getRight;
    int l_data = Provider.of<BleData>(context).l_data;
    List<int> r_data = Provider.of<BleData>(context).r_data;
    final joystickRadius = queryData.size.height * 0.6;
    return Row(
      children: [
        Center(child: JoystickLeft(size_h: joystickRadius, get_data: getLeft)),
        Terminal(
            size_w: (queryData.size.width - (joystickRadius * 2)),
            size_h: queryData.size.height * 0.3,
            message: [l_data.toString(), r_data.toString()]),
        Center(child: JoystickRight(size_h: joystickRadius, get_data: getRight))
      ],
    );
  }
}

class BleMenu extends StatefulWidget {
  const BleMenu({Key? key}) : super(key: key);

  @override
  _BleMenuState createState() => _BleMenuState();
}

class _BleMenuState extends State<BleMenu> {
  bool ble_visib = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Abdul Samet Durmaz"),
        IconButton(
            onPressed: () {
              (ble_visib == true) ? ble_visib = false : ble_visib = true;
              setState(() {});
            },
            icon: Icon(Icons.menu)),
        Visibility(
          child: Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Provider.of<BleData>(context, listen: false).deneme();
                  },
                  child: Text("Plane Connect")),
              ElevatedButton(
                  onPressed: () {
                    Provider.of<BleData>(context, listen: false)
                        .send("abdul samet durmaz \n");
                  },
                  child: Text("dene")),
            ],
          ),
          visible: ble_visib,
        ),
        Spacer(),
        Text("Connecting = " +
            Provider.of<BleData>(context, listen: true)
                .connecting_state
                .toString()),
      ],
    );
  }
}
