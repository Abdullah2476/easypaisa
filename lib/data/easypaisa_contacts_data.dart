import '../models/easypaisa_contact_model.dart';

/// -------------------------------------------------------------
/// CONTACTS DATA (JSON FORMAT)
/// You can easily add more contacts or accounts to this list below!
/// -------------------------------------------------------------
const List<Map<String, dynamic>> easypaisaContactsRawData = [
  {
    'id': '1',
    'name': 'Flutter With Ahmad',
    'phoneNumber': '03119818545',
    'initials': 'FW',
  },
  {
    'id': '2',
    'name': 'Ali Khan',
    'phoneNumber': '03001234567',
    'initials': 'AK',
  },
  {
    'id': '3',
    'name': 'Usman Tariq',
    'phoneNumber': '03219876543',
    'initials': 'UT',
  },
  {
    'id': '4',
    'name': 'Zainab Bibi',
    'phoneNumber': '03335551234',
    'initials': 'ZB',
  },
  {
    'id': '5',
    'name': 'Bilal Ahmed',
    'phoneNumber': '03456789012',
    'initials': 'BA',
  },
];

/// Parsed list of models from raw JSON list
final List<EasypaisaContactModel> easypaisaContactsList = easypaisaContactsRawData
    .map((json) => EasypaisaContactModel.fromJson(json))
    .toList();

/// Filter contacts by phone number or name using Dart's .where() method
List<EasypaisaContactModel> filterContactsByQuery(String query) {
  final cleanQuery = query.replaceAll(' ', '').trim().toLowerCase();
  if (cleanQuery.isEmpty) {
    return [];
  }

  // Using .where() for filtering as explicitly required
  return easypaisaContactsList.where((contact) {
    final cleanPhone = contact.phoneNumber.replaceAll(' ', '').toLowerCase();
    final cleanName = contact.name.toLowerCase();
    return cleanPhone.contains(cleanQuery) || cleanName.contains(cleanQuery);
  }).toList();
}
