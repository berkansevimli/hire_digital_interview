import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_reservation/models/customer.dart';
import 'package:restaurant_reservation/provider/general_provider.dart';
import 'package:restaurant_reservation/screens/make_appointment.dart';

import '../models/appointment.dart';
import '../models/restaurant.dart';

class AllRestaurants extends StatefulWidget {
  final Customer customer;
  const AllRestaurants({Key? key, required this.customer}) : super(key: key);

  @override
  State<AllRestaurants> createState() => _AllRestaurantsState();
}

class _AllRestaurantsState extends State<AllRestaurants> {
  @override
  Widget build(BuildContext context) {
    final List<Restaurant> _restaurants = [
      Restaurant(
          restaurantID: "happy1",
          title: "Happy Moon's",
          description:
              "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
          appointments: appointments),
      Restaurant(
          restaurantID: "burger1",
          title: "Burger King",
          description:
              "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
          appointments: appointments),
      Restaurant(
          restaurantID: "bigchefs",
          title: "Big Chefs",
          description:
              "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
          appointments: appointments)
    ];
    return Scaffold(
        appBar: AppBar(title: Text("Restaurants")),
        body: ListView(
          children: _restaurants.map((Restaurant element) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                  title: Text(element.title!),
                  subtitle: Text(element.description!),
                  trailing: Icon(Icons.chevron_right),
                  onTap: (() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => MakeAppointment(
                                  restaurant: element,
                                  customer: widget.customer,
                                )));
                  })),
            );
          }).toList(),
        ));
  }
}
