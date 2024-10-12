//import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:get/get.dart';
import 'package:flutter_application_3/alController/controller_vpn_location.dart';
//import 'package:flutter_application_3/alModels/vpn_info.dart';
import 'package:flutter_application_3/alWidgets/vpn_location_card_widget.dart';

class AvailableVpnServersLocationScreen extends StatelessWidget {
  AvailableVpnServersLocationScreen({super.key});
  final vpnLocationController = ControllerVpnLocation();
  loadingUIWidget() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "Gathering Free VPN Location ... ",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  noVpnServerFoundUIWidget() {
    return Center(
        child: Text(
      "No VPNs Found , Try again ",
      style: TextStyle(
        fontSize: 18,
        color: Colors.black54,
        fontWeight: FontWeight.bold,
      ),
    ));
  }

  vpnAvailableServerData() {
    return ListView.builder(
      itemCount: vpnLocationController.vpnFreeServerAvailableList.length,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(3),
      itemBuilder: (context, index) {
        return VpnLocationCardWidget(
            vpnInfo: vpnLocationController.vpnFreeServerAvailableList[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // if (vpnLocationController.vpnFreeServerAvailableList.isEmpty) {
    //   vpnLocationController.retrieveVpnInformation();
    // }
    return  Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.redAccent,
            title: Text(
              "VPN Locations " +
                  vpnLocationController.vpnFreeServerAvailableList.length
                      .toString(),
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 18, right: 10),
            child: FloatingActionButton(
              backgroundColor: Colors.redAccent,
              onPressed: ()async{
                vpnLocationController.isLoadingNowLocations.value = true;
                await vpnLocationController.retrieveVpnInformation();
                vpnLocationController.isLoadingNowLocations.value = false;
              },
              child: Icon(
                CupertinoIcons.refresh_circled,
                size: 40,
              ),

            ),),
          body: vpnLocationController.isLoadingNowLocations.value
              ? loadingUIWidget()
              : vpnLocationController.vpnFreeServerAvailableList.isEmpty
              ? noVpnServerFoundUIWidget()
              : vpnAvailableServerData(),
        );
  }
}
