import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../constants/enums.dart';
import '../../infrastructure/connectivity_repository.dart';

part 'connectivity_cubit.freezed.dart';
part 'connectivity_state.dart';



class ConnectivityCubit extends Cubit<ConnectivityState> {

  ConnectivityRepository connectivityRepository;
  late final StreamSubscription<List<ConnectivityResult>> connectivitySubscription;

  ConnectivityCubit(this.connectivityRepository) : super(const ConnectivityState.initial()) {
    _init();
  }


  Future<void> _init() async {
    await connectivityRepository.initConnectivity();
    Connectivity connectivity = connectivityRepository.connectivity;
    connectivitySubscription =  connectivity.onConnectivityChanged.listen((result){
      _updateConnectionStatus(result);
    }) ;
  }


  void _updateConnectionStatus(List<ConnectivityResult> result) {
    if (result.contains(ConnectivityResult.none)) {
      emit(const ConnectivityState.offline());
    }
    if (result.contains(ConnectivityResult.mobile)) {
      emit(const ConnectivityState.online(type: ConnectionType.mobile));
    }
    if (result.contains(ConnectivityResult.wifi)) {
      emit(const ConnectivityState.online(type: ConnectionType.wifi));
    }
    if (result.length == 1 && result.contains(ConnectivityResult.vpn)) {
      emit(const ConnectivityState.offline());
    }
  }

  @override
  Future<void> close ()async {
    connectivitySubscription.cancel();
    super.close();
  }
}
