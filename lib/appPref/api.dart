import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserApi {
  Future<Map<String, dynamic>> getUser() async {
    final response = await http.get(Uri.parse('https://retoolapi.dev/oV6SD8/userData'));

    if (response.statusCode == 200) {
      try {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } catch (e) {
        throw Exception('Failed to decode JSON data: $e');
      }
    } else {
      throw Exception('Failed to load user data');
    }
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, dynamic> _userData = {};

  Future<void> _loadUserData() async {
    final userApi = UserApi();
    final userData = await userApi.getUser();

    setState(() {
      _userData = userData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User  API'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('ID: ${_userData['id'] ?? 'N/A'}'),
            Text('Name: ${_userData['name'] ?? 'N/A'}'),
            Text('Email: ${_userData['email'] ?? 'N/A'}'),
            Text('Country: ${_userData['country'] ?? 'N/A'}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loadUserData,
              child: Text('Load User Data'),
            ),
          ],
        ),
      ),
    );
  }
}