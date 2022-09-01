import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_reservation/models/appointment.dart';
import 'package:restaurant_reservation/models/customer.dart';
import 'package:restaurant_reservation/models/restaurant.dart';
import 'package:restaurant_reservation/provider/general_provider.dart';

class MakeAppointment extends StatefulWidget {
  final Restaurant restaurant;
  final Customer customer;
  const MakeAppointment(
      {Key? key, required this.restaurant, required this.customer})
      : super(key: key);

  @override
  State<MakeAppointment> createState() => _MakeAppointmentState();
}

class _MakeAppointmentState extends State<MakeAppointment> {
  DateTime selectedTime = DateTime.now();
  List<DateTime> hours = [];
  List<DateTime> busyHours = [];
  List<DateTime> appointmentStarts = [];
  //Sample Service duration
  int duration = 60;
  // Restaurant Opening Hour
  DateTime startTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 9, 0, 0);
  // Restaurant Closing Hour
  DateTime endTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 19, 00, 0);

  @override
  void initState() {
    getHours();
    getAvailableHours();
    super.initState();
  }

  getHours() {
    // Create Time Slots
    for (DateTime i = startTime;
        i.isBefore(endTime);
        i = i.add(Duration(minutes: 15))) {
      print(i);
      setState(() {
        hours.add(i);
      });
    }
  }

  getAvailableHours() {
    // Get available hours
    widget.restaurant.appointments!.forEach((element) {
      for (DateTime dt = element.startTime;
          dt.isBefore(element.endTime);
          dt = dt.add(Duration(minutes: 15))) {
        setState(() {
          busyHours.add(dt);
          hours.remove(dt);
        });
      }
      for (int i = 0; i < (duration / 15); i++) {
        print(i);
        busyHours.add(element.startTime.subtract(Duration(minutes: (i) * 15)));
        hours.remove(element.startTime.subtract(Duration(minutes: (i) * 15)));
      }
    });

    print("hours: ${hours}");
    print(busyHours);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GeneralProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Select Time")),
      body: SingleChildScrollView(
          child: Column(
        children: hours.map((hour) {
          return Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListTile(
                title:
                    Text(hour.hour.toString() + ":" + hour.minute.toString()),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (builder) => AlertDialog(
                            title: Text("Approve your appointment"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Details"),
                                Divider(),
                                ListTile(
                                  title: Text("Restaurant"),
                                  subtitle: Text(widget.restaurant.title!),
                                ),
                                ListTile(
                                  title: Text("Customer"),
                                  subtitle: Text(widget.customer.fullName!),
                                ),
                                ListTile(
                                  title: Text("Date & Time"),
                                  subtitle: Text("${hour.toString()}"),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Cancel")),
                              TextButton(
                                  onPressed: () {
                                    Appointment appointment = Appointment(
                                        title: widget.customer.fullName!,
                                        description: "description",
                                        startTime: hour,
                                        endTime: hour
                                            .add(Duration(minutes: duration)),
                                        customerName:
                                            widget.customer.fullName!);
                                    provider.makeAppointment(appointment,
                                        widget.customer, widget.restaurant);
                                  },
                                  child: Text("Approve")),
                            ],
                          ));
                },
              ));
        }).toList(),
      )),
    );
  }
}
