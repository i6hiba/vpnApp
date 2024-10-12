import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_3/alModels/vpn_configuration.dart';
import 'package:flutter_application_3/alModels/vpn_info.dart';
import 'package:flutter_application_3/appPref/appPref.dart';
import 'package:flutter_application_3/vpnEngin/vpn_engine.dart';
// import 'package:get/get.dart';

class ControllerHome extends GetxController {
  final Rx<VpnInfo> vpnInfo = AppPreferences.vpnInfoObj.obs;

  final vpnConnectionState = VpnEngine.vpnDisconnectedNow.obs;
  void connecttoVpnNow() async {
    if (vpnInfo.value.Base64OpenVPNConfigurationData.isEmpty) {
      Get.snackbar(
          "Country / Location", "Please select Country or location first");
      return;
    }
    if (vpnConnectionState.value == VpnEngine.vpnDisconnectedNow) {
      final dataConfigVpn =
          Base64Decoder().convert(vpnInfo.value.Base64OpenVPNConfigurationData);
      final configuration = Utf8Decoder().convert(dataConfigVpn);
      final vpnConfiguration = VpnConfiguration(
          username: "vpn",
          password: "vpn",
          countryName: vpnInfo.value.countryLongName,
          config: configuration);
      await VpnEngine.startVpnNow(vpnConfiguration);
    } else {
      await VpnEngine.stopVpnNow();
    }
  }

  Color get getRoundVpnButtonColor {
    switch (vpnConnectionState.value) {
      case VpnEngine.vpnDisconnectedNow:
        return Colors.redAccent;
      case VpnEngine.vpnConnectedNow:
        return Colors.green;
      default:
        return Colors.orangeAccent;
    }
  }

  String get getRoundVpnButtonText {
    switch (vpnConnectionState.value) {
      case VpnEngine.vpnDisconnectedNow:
        return "Tap to connect";
      case VpnEngine.vpnConnectedNow:
        return "Disconnect";
      default:
        return "Connecting ...";
    }
  }
}
