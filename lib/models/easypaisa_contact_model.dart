/// Contact / Account model for Easypaisa Transfer.
class EasypaisaContactModel {
  final String id;
  final String name;
  final String phoneNumber;
  final String initials;

  const EasypaisaContactModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.initials,
  });

  /// Factory constructor to create an instance from JSON map.
  factory EasypaisaContactModel.fromJson(Map<String, dynamic> json) {
    return EasypaisaContactModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      initials: json['initials'] as String? ?? '',
    );
  }

  /// Convert model to JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'initials': initials,
    };
  }

  /// Helper to generate initials if not explicitly provided
  static String extractInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    } else if (parts.isNotEmpty && parts[0].isNotEmpty) {
      return parts[0].substring(0, parts[0].length >= 2 ? 2 : 1).toUpperCase();
    }
    return 'EP';
  }
}
