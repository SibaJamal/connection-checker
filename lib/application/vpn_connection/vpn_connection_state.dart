part of 'vpn_connection_cubit.dart';

@freezed
class VpnConnectionState with _$VpnConnectionState {
  const factory VpnConnectionState.init() = _Init;
  const factory VpnConnectionState.connected() = _Connected;
  const factory VpnConnectionState.notConnected() = _NotConnected;


}