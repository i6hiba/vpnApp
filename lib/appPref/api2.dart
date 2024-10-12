import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


// MealPlanPage displays a list of meal plans.
class VpnApp extends StatefulWidget {
  const VpnApp({super.key});

  @override
  _VpnAppState createState() => _VpnAppState();
}

// State for MealPlanPage
class _VpnAppState extends State<VpnApp> {
  List<Map<String, dynamic>> VpnApp = []; // List to hold meal plans
  bool isLoading = true; // Loading indicator
  String errorMessage = ''; // Error message

  @override
  void initState() {
    super.initState();
    _loadMealPlan(); // Load meal plans on initialization
  }

  // Function to load meal plans from an API
  Future<void> _loadMealPlan() async {
    try {
      final response = await http.get(Uri.parse('https://retoolapi.dev/oV6SD8/userData')); // API call
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body); // Decode JSON data
        setState(() {
          VpnApp = jsonData.map((item) => item as Map<String, dynamic>).toList(); // Convert to list of maps
          isLoading = false; // Update loading state
        });
      } else {
        setState(() {
          errorMessage = 'فشل في تحميل البيانات: ${response.statusCode}'; // Error message for failed request
          isLoading = false; // Update loading state
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'حدث خطأ: $e'; // Error handling
        isLoading = false; // Update loading state
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: isLoading
          ? const Center(child: CircularProgressIndicator()) // Loading indicator
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage, style: const TextStyle(color: Colors.red))) // Error message display
              : Column(
                  children: [
                    Container(
                      
                      child: const Text('User Info', style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold , color: Colors.black))), // Title
                    Expanded(
                      child: ListView.builder(
                        itemCount: VpnApp.length, // Number of meal plans
                        itemBuilder: (context, index) {
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 7.0), // Card margin
                            child: ListTile(
                              leading: CircleAvatar(child: Icon(Icons.location_history),),
                              title: Text(VpnApp[index]['name']), // Meal name
                              subtitle: Text(VpnApp[index]['email']),
                              trailing: 
                               Icon(Icons.person), 
                              // Date of the meal
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}