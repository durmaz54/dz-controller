import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BleData extends ChangeNotifier {
  late BluetoothConnection connection;
  int l_data = 0;
  List<int> r_data = [0, 0];
  void getLeft(int a) {
    l_data = a;
    notifyListeners();
  }

  void getRight(int x, int y) {
    r_data = [x, y];
    notifyListeners();
  }

  void deneme() async {
    try {
      BluetoothConnection connection =
          await BluetoothConnection.toAddress("00:13:EF:00:25:47");
    } catch (ex) {
      print(ex);
    }
  }

  Future send(Uint8List data) async {
    connection.output.add(data);
    await connection.output.allSent;
  }
}
