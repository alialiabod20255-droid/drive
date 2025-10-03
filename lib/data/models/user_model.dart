class AppUser {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String role; // admin, employee, driver

  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
  });

  factory AppUser.fromMap(String id, Map<String, dynamic> data) {
    return AppUser(
      id: id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      role: data['role'] ?? 'employee',
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'email': email,
        'phone': phone,
        'role': role,
      };
}
