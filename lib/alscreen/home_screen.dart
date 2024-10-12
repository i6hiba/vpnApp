import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/alController/controller_home.dart';
import 'package:flutter_application_3/alModels/vpn_status.dart';
import 'package:flutter_application_3/alWidgets/custom_widget.dart';
import 'package:flutter_application_3/alWidgets/timer_widget.dart';
import 'package:flutter_application_3/alscreen/LoginPage.dart';
import 'package:flutter_application_3/alscreen/available_vpn_servers_location_screen.dart';
import 'package:flutter_application_3/appPref/api2.dart';
//import 'package:flutter_application_3/alscreen/connected_network_ip_info_screen.dart';
import 'package:flutter_application_3/appPref/appPref.dart';
import 'package:flutter_application_3/main.dart';
import 'package:flutter_application_3/vpnEngin/vpn_engine.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final homeController = Get.put(ControllerHome());

  locationSelectionBottomNavigation(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
          child: Semantics(
        button: true,
        child: InkWell(
          onTap: () {
            Get.to(() => AvailableVpnServersLocationScreen());
          },
          child: Container(
            color: Colors.redAccent,
            padding: EdgeInsets.symmetric(horizontal: sizeScreen.width * .04),
            height: 62,
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.flag_circle,
                  color: Colors.white,
                  size: 36,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  "Select Country /location ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
                Spacer(),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.redAccent,
                    size: 26,
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget vpnRoundButton() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Semantics(
            button: true,
            child: InkWell(
              onTap: () {
                homeController.connecttoVpnNow();
              },
              borderRadius: BorderRadius.circular(100),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: homeController.getRoundVpnButtonColor.withOpacity(.1),
                ),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: homeController.getRoundVpnButtonColor.withOpacity(.3),
                  ),
                  child: Container(
                    height: sizeScreen.height * .14,
                    width: sizeScreen.height * .14,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: homeController.getRoundVpnButtonColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.power_settings_new,
                          size: 30,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          homeController.getRoundVpnButtonText,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        Container(
          margin: EdgeInsets.only(top: sizeScreen.height * .08, bottom: sizeScreen.height * .04),
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(16),
           ),
          child: Text(
            homeController.vpnConnectionState.value == VpnEngine.vpnDisconnectedNow? "Not connected " : homeController.vpnConnectionState.replaceAll("_", " ").toUpperCase(),
            style: TextStyle(
              fontSize: 13,
              color: Colors.white,
             ),
            ),
        )
        ,Obx(() => TimerWidget(initTimerNow: homeController.vpnConnectionState.value == VpnEngine.vpnConnectedNow) )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    VpnEngine.snapshotvpnStage().listen((event) {
      homeController.vpnConnectionState.value = event;
    });
    sizeScreen = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text('Free VPN'),
          leading: IconButton(
            onPressed: () {
              
              Get.to(() => LoginPage());
            },
            icon: Icon(Icons.perm_device_info),
          ),
          actions: [
            IconButton(
              onPressed: () {
                AppPreferences.isModeDark = !AppPreferences.isModeDark;
                Get.changeThemeMode(AppPreferences.isModeDark
                    ? ThemeMode.dark
                    : ThemeMode.light);
                AppPreferences.isModeDark = AppPreferences.isModeDark;
              },
              icon: Icon(Icons.brightness_2_outlined),
            ),
            IconButton(
            onPressed: () {
              
              Get.to(() => VpnApp());
            },
            icon: Icon(Icons.info_outline),
          ),
          ],
        ),
        bottomNavigationBar: locationSelectionBottomNavigation(context),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 20,),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomWidget(
                        titleText:
                            homeController.vpnInfo.value.countryLongName.isEmpty
                                ? "Location"
                                : homeController.vpnInfo.value.countryLongName,
                        subTitleText: "FREE",
                        roundWidgetWithIcon: CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.redAccent,
                          child:
                              homeController.vpnInfo.value.countryLongName.isEmpty
                                  ? Icon(
                                      Icons.flag_circle,
                                      size: 30,
                                      color: Colors.white,
                                    )
                                  : null,
                          backgroundImage: homeController
                                  .vpnInfo.value.countryLongName.isEmpty
                              ? null
                              : AssetImage(
                                  "countryFlags/${homeController.vpnInfo.value.countryShortName.toLowerCase()}.png"),
                        )),
                    CustomWidget(
                        titleText:
                            homeController.vpnInfo.value.countryLongName.isEmpty
                                ? "60 ms"
                                : homeController.vpnInfo.value.ping + "ms",
                        subTitleText: "PING",
                        roundWidgetWithIcon: CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.black54,
                          child: Icon(
                            Icons.graphic_eq,
                            size: 30,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
              Row(
                children: [],
              ),
              Obx(() => vpnRoundButton()),
              Row(
                children: [],
              ),
              StreamBuilder<VpnStatus?>(
                  initialData: VpnStatus(),
                  stream: VpnEngine.snapshotVpnStatus(),
                  builder: (context, dataSnapshot) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomWidget(
                              titleText:
                                  "${dataSnapshot.data?.byteIn ?? '0 kbps'}",
                              subTitleText: "DOWNLOAD",
                              roundWidgetWithIcon: CircleAvatar(
                                radius: 32,
                                backgroundColor: Colors.green,
                                child: Icon(
                                  Icons.arrow_circle_down,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              )),
                          CustomWidget(
                              titleText:
                                  "${dataSnapshot.data?.byteOut ?? '0 kbps'}",
                              subTitleText: "UPLOAD",
                              roundWidgetWithIcon: CircleAvatar(
                                radius: 32,
                                backgroundColor: Colors.purpleAccent,
                                child: Icon(
                                  Icons.arrow_circle_up_rounded,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              )),
                        ],
                      )),
            ],
          ),
        ));
  }
}
