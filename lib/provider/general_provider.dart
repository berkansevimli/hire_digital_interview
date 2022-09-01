import 'package:flutter/material.dart';
import 'package:restaurant_reservation/models/appointment.dart';
import 'package:restaurant_reservation/models/customer.dart';
import 'package:restaurant_reservation/screens/all_restaurants.dart';

class GeneralProvider extends ChangeNotifier {
  final List<Customer> _customers = [];
  List<Customer> get customers => _customers;

  Customer? _currentUser = null;
  Customer get currentUser => currentUser;

  void signUp(Customer customer, BuildContext context) {
    _customers.add(customer);
    _currentUser = customer;
    notifyListeners();

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (builder) => AllRestaurants(customer: customer)),
        (route) => false);
  }

  void makeAppointment(Appointment appointment, Customer customer) {
    customer.appointments.add(appointment);
  }

  void signIn(String email, password) {}
}
