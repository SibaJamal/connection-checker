import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../infrastructure/connectivity_repository.dart';

part 'vpn_connection_cubit.freezed.dart';
part 'vpn_connection_state.dart';


class VpnConnectionCubit extends Cubit<VpnConnectionState> {
  ConnectivityRepository connectivityRepository;
  late final StreamSubscription<
      List<ConnectivityResult>> connectivitySubscription;

  VpnConnectionCubit(this.connectivityRepository)
      : super(const VpnConnectionState.init()) {
    _init();
  }

  Future<void> _init() async {
    await connectivityRepository.initConnectivity();
    Connectivity connectivity = connectivityRepository.connectivity;
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen((result) {
          _updateConnectionStatus(result);
        });
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    if (result.contains(ConnectivityResult.vpn)) {
      emit(const VpnConnectionState.connected());
    }
    else {
      emit(const VpnConnectionState.notConnected());
    }
  }
  @override
  Future<void> close() async {
    connectivitySubscription.cancel();
    super.close();
  }
}