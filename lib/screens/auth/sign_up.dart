import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_reservation/models/customer.dart';
import 'package:restaurant_reservation/provider/general_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  String? name;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GeneralProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildName(),
              buildEmail(),
              buildPassword(),
              SizedBox(
                height: 16,
              ),
              TextButton(
                  onPressed: () {
                    _formKey.currentState!.save();
                    if (_formKey.currentState!.validate()) {
                      Customer customer = Customer(
                          email: email,
                          password: password,
                          fullName: name,
                          appointments: []);
                      provider.signUp(customer, context);
                    }
                  },
                  child: Text("Sign Up"))
            ],
          ),
        ),
      )),
    );
  }

  Padding buildPassword() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(hintText: "Password"),
        onSaved: (newValue) {
          setState(() {
            password = newValue;
          });
        },
        obscureText: true,
        validator: (value) {
          if (value!.isEmpty) {
            return "Password is required";
          } else if (value.length < 6) {
            return "Please enter min 6 characters";
          }
          return null;
        },
      ),
    );
  }

  Padding buildEmail() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(hintText: "E-mail"),
        onSaved: (newValue) {
          setState(() {
            email = newValue;
          });
        },
        validator: (value) {
          if (value!.isEmpty) {
            return "Email is required";
          }
          return null;
        },
      ),
    );
  }

  Padding buildName() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(hintText: "Name"),
        onSaved: (newValue) {
          setState(() {
            name = newValue;
          });
        },
        validator: (value) {
          if (value!.isEmpty) {
            return "Name is required";
          }
          return null;
        },
      ),
    );
  }
}
