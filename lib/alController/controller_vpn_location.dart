import 'package:flutter_application_3/alModels/vpn_info.dart';
import 'package:flutter_application_3/alVpnGate/api_vpn_gate.dart';
import 'package:flutter_application_3/appPref/appPref.dart';
import 'package:get/get.dart';

class ControllerVpnLocation extends GetxController {
  List<VpnInfo> vpnFreeServerAvailableList = AppPreferences.vpnList;
  final RxBool isLoadingNowLocations = false.obs;
  Future<void> retrieveVpnInformation() async {
    isLoadingNowLocations.value = true;
    vpnFreeServerAvailableList.clear();
    vpnFreeServerAvailableList = await ApiVpnGate.retrieveAllAvailableFreeVpnServers();
    isLoadingNowLocations.value = false;


  }
}
