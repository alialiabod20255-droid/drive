class ViolationModel {
  final String id;
  final String driverId;
  final String type;
  final DateTime date;
  final int pointsDeducted;
  final String status; // pending, resolved

  const ViolationModel({
    required this.id,
    required this.driverId,
    required this.type,
    required this.date,
    required this.pointsDeducted,
    required this.status,
  });

  factory ViolationModel.fromMap(String id, Map<String, dynamic> data) {
    return ViolationModel(
      id: id,
      driverId: data['driver_id'] ?? '',
      type: data['type'] ?? '',
      date: DateTime.tryParse(data['date']?.toString() ?? '') ?? DateTime.now(),
      pointsDeducted: (data['points_deducted'] ?? 0) as int,
      status: data['status'] ?? 'pending',
    );
  }

  Map<String, dynamic> toMap() => {
        'driver_id': driverId,
        'type': type,
        'date': date.toIso8601String(),
        'points_deducted': pointsDeducted,
        'status': status,
      };
}
