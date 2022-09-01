class Customer {
  final String? fullName;
  final String? email;
  final String? password;
  final List appointments;

  Customer({
    required this.email,
    required this.password,
    required this.fullName,
    required this.appointments,
  });
}
