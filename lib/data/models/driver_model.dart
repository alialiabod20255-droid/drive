class DriverModel {
  final String id;
  final String name;
  final String phone;
  final String licenseNumber;
  final int points;
  final bool licenseSuspended;
  final DateTime createdAt;

  const DriverModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.licenseNumber,
    required this.points,
    required this.licenseSuspended,
    required this.createdAt,
  });

  DriverModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? licenseNumber,
    int? points,
    bool? licenseSuspended,
    DateTime? createdAt,
  }) => DriverModel(
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        licenseNumber: licenseNumber ?? this.licenseNumber,
        points: points ?? this.points,
        licenseSuspended: licenseSuspended ?? this.licenseSuspended,
        createdAt: createdAt ?? this.createdAt,
      );

  factory DriverModel.fromMap(String id, Map<String, dynamic> data) {
    return DriverModel(
      id: id,
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
      licenseNumber: data['license_number'] ?? '',
      points: (data['points'] ?? 12) as int,
      licenseSuspended: (data['license_suspended'] ?? false) as bool,
      createdAt: (data['created_at'] as DateTime?) ?? DateTime.tryParse(data['created_at']?.toString() ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'phone': phone,
        'license_number': licenseNumber,
        'points': points,
        'license_suspended': licenseSuspended,
        'created_at': createdAt.toIso8601String(),
      };
}
