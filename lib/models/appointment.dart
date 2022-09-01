class Appointment {
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final String customerName;

  Appointment({
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.customerName,
  });
}

List<Appointment> appointments = [
  Appointment(
      title: "Berkan's Reservation",
      description: "description",
      startTime: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 9, 0, 0),
      endTime: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 9, 45, 0),
      customerName: "Berkan"),
  Appointment(
      title: "Feyza's Reservation",
      description: "description",
      startTime: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 11, 30, 0),
      endTime: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 12, 30, 0),
      customerName: "Feyza"),
  Appointment(
      title: "Alice's Reservation",
      description: "description",
      startTime: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 14, 45, 0),
      endTime: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 15, 15, 0),
      customerName: "Alice"),
  Appointment(
      title: "Dan's Reservation",
      description: "description",
      startTime: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 16, 30, 0),
      endTime: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 17, 45, 0),
      customerName: "Dan"),
  Appointment(
      title: "Charlie's Reservation",
      description: "description",
      startTime: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 18, 0, 0),
      endTime: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 19, 0, 0),
      customerName: "Charlie"),
];
