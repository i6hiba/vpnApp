class VpnInfo {
  late final String hostname;
  late final String ip;
  late final String ping;
  late final int speed;
  late final String countryLongName;
  late final String countryShortName;
  late final int vpnSessionsnum;
  late final String Base64OpenVPNConfigurationData;
  VpnInfo({
    required this.hostname,
    required this.ip,
    required this.ping,
    required this.speed,
    required this.countryLongName,
    required this.countryShortName,
    required this.vpnSessionsnum,
    required this.Base64OpenVPNConfigurationData,
  });
  VpnInfo.fromJson(Map<String, dynamic> jsonData) {
    hostname = jsonData["Hostname"] ?? "";
    ip = jsonData["IP"] ?? '';
    ping = jsonData["PING"].toString();
    speed = jsonData["Speed"] ?? 0;
    countryLongName = jsonData["CountryLong"] ?? '';
    countryShortName = jsonData["CountryShort"] ?? '';
    vpnSessionsnum = jsonData["NumVPNSessions"] ?? 0;
    Base64OpenVPNConfigurationData =
        jsonData["OpenVPN_ConfigData_Base64"] ?? '';
  }
  Map<String, dynamic> toJson() {
    final jsonData = <String, dynamic>{};
    jsonData['Hostname'] = hostname;
    jsonData['IP'] = ip;
    jsonData['PING'] = ping;
    jsonData['Speed'] = speed;
    jsonData['CountryLong'] = countryLongName;
    jsonData['CountryShort'] = countryShortName;
    jsonData['NumVPNSessions'] = vpnSessionsnum;
    jsonData['OpenVPN_ConfigData_Base64'] = Base64OpenVPNConfigurationData;
    return jsonData;
  }
}
