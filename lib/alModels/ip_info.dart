//import 'dart:convert';
class IpInfo {
  late final String countryName;
  late final String regionName;
  late final String cityName;
  late final String zipCode;
  late final String timezone;
  late final String internetSeviceProvider;
  late final String query;

  IpInfo({
    required this.countryName,
    required this.regionName,
    required this.cityName,
    required this.zipCode,
    required this.timezone,
    required this.internetSeviceProvider,
    required this.query,
  });

  IpInfo.fromJson(Map<String, dynamic> jsonData) {
    countryName = jsonData['country'];
    regionName = jsonData['regionName'] ?? '';
    cityName = jsonData['city'] ?? '';
    zipCode = jsonData['zip'] ?? '';
    timezone = jsonData['timezone'] ?? 'Unknown';
    internetSeviceProvider = jsonData['isp'] ?? 'Unknown';
    query = jsonData['query'] ?? 'Not available';

  }
}
