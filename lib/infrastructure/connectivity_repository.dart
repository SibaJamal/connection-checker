import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

class ConnectivityRepository {
  List<ConnectivityResult> connectionStatus = [ConnectivityResult.none];
  final Connectivity connectivity = Connectivity();


  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;

    try {
      result = await connectivity.checkConnectivity();
      connectionStatus = result;
    } on PlatformException catch (e) {
      print('Couldn\'t check connectivity status $e');
      return;
    }
    return updateConnectionStatus(result);
  }

  Future<void> updateConnectionStatus(List<ConnectivityResult> result) async {
      connectionStatus = result;
    print('Connectivity changed: $connectionStatus');
  }
}