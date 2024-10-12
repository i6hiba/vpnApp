import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart'; // Add this import

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _password = '';

  // New method to store user data in Cloud Firestore
  Future<void> _storeUserData() async {
  try {
    final firestore = FirebaseFirestore.instance;
    final userRef = firestore.collection('users').doc(_email);

    await userRef.set({
      'name': _name,
      'email': _email,
      'password':_password,
    });
  } catch (e) {
    print('Error storing user data: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty || !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onSaved: (value) => _email = value!,
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty || value.length < 8) {
                    return 'Please enter a password with at least 8 characters';
                  }
                  return null;
                },
                onSaved: (value) => _password = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
  onPressed: () async {
    if (_formKey.currentState!.validate()) {
      _showSuccessMessage('Your login data has been stored successfully!');
      _formKey.currentState!.save();      
      await _storeUserData().then((_) {
        print('User data stored successfully!');
      }).catchError((e) {
        print('Error storing user data: $e');
      });
    }
            

  },
  child: Text('Login'),
),
            ],
          ),
        ),
      ),
    );
  }
}
void _showSuccessMessage(String message) {
  // You can use a package like fluttertoast or rflutter_alert to show a toast or alert
  // For example, with fluttertoast:
  Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_SHORT);
}