import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BleData extends ChangeNotifier {
  BluetoothConnection? connection;
  int l_data = 0;
  List<int> r_data = [0, 0];
  bool connecting_state = false;
  void getLeft(int a) {
    l_data = a;
    notifyListeners();
    this.send(l_data.toString() + "\n");
  }

  void getRight(int x, int y) {
    r_data = [x, y];
    this.send(r_data.toString() + " \n");
    notifyListeners();
  }

  void deneme() async {
    try {
      this.connection =
          await BluetoothConnection.toAddress("00:13:EF:00:25:47");
      print("bağlantı başarılıııııııııııııııııı");
      (this.connecting_state == true)
          ? this.connecting_state = false
          : this.connecting_state = true;
      notifyListeners();
    } catch (ex) {
      print(ex);
    }
  }

  Future send(var data) async {
    if (!(this.connection == null)) {
      data = Uint8List.fromList(data.codeUnits);
      this.connection!.output.add(data);
      await this.connection!.output.allSent;
    }
  }
}
