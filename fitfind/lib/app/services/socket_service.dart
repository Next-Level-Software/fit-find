import 'dart:io';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '/app/environment/environment.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketService extends GetxService {
  SocketService._();

  Future<SocketService> init() async {
    initSocket();
    return this;
  }

  static initSocket() {
    if (!socket.connected) {
      socket.connect();
    }
    Logger().i("socket: ${socket.connected}");
  }

  static Socket socket = io(BASE_URL, <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });
}

// //? https://punjabicoder.medium.com/adb-command-not-found-mac-os-69b3f2bb3859
// //! if => adb command not found ERROR