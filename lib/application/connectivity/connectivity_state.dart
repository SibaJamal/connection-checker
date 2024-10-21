part of 'connectivity_cubit.dart';


@freezed
class ConnectivityState with _$ConnectivityState {
  const factory ConnectivityState.initial() = _Initial;

  const factory ConnectivityState.online({ required ConnectionType type}) = _Online;

  const factory ConnectivityState.offline() = _Offline;
}