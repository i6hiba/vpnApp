import 'package:flutter/services.dart';
import 'package:flutter_application_3/alModels/vpn_configuration.dart';
import 'package:flutter_application_3/alModels/vpn_status.dart';
import 'dart:convert';
class VpnEngine {
  static final String eventChannelVPNStage = "vpnStage";
  static final String eventChannelVPNStatus = "vpnStatus";
  static final String methodChannelVpnControl = "vpnControl";

  static Stream<String> snapshotvpnStage() =>
      EventChannel(eventChannelVPNStage).receiveBroadcastStream().cast();

  static Stream<VpnStatus?> snapshotVpnStatus() => EventChannel(eventChannelVPNStatus).receiveBroadcastStream()
  .map((eventStatus) => VpnStatus.fromJson(jsonDecode(eventStatus))).cast();
  
  static Future<void> startVpnNow(VpnConfiguration vpnConfiguration) async {
    return MethodChannel(methodChannelVpnControl).invokeMethod(
      "start" ,
      {
        "config" : vpnConfiguration.config,
        "country": vpnConfiguration.countryName,
        "username" :vpnConfiguration.username,
        "password" : vpnConfiguration.password,

      },
    );
  }
  static Future<void> stopVpnNow(){
    return MethodChannel(methodChannelVpnControl).invokeMethod("stop");
  }
  static Future<void> killSwitchOpenNow(){
    return MethodChannel(methodChannelVpnControl).invokeMethod("kill_switch");
  }
  static Future<void> refreshStageNow(){
    return MethodChannel(methodChannelVpnControl).invokeMethod("refresh");
  }
  static Future<String?> getStageNow(){
    return MethodChannel(methodChannelVpnControl).invokeMethod("stage");
  }
  static Future<bool> isConnectedNow(){
    return getStageNow().then((valueStage) => valueStage!.toLowerCase() == "connected" );  }
  static const String vpnConnectedNow = "connected";
  static const String vpnDisconnectedNow = "disconnected";
  static const String vpnWaitConnectionNow = "Wait_connection";
  static const String vpnAuthenticationNow = "authenticating";
  static const String vpnReconnectNow = "reconnect";
  static const String vpnNoConnectionNow = "no_connection";
  static const String vpnConnectingNow = "connecting";
  static const String vpnPrepareNow = "prepare";
  static const String vpnDeniedNow = "denied";
}
