import 'package:flutter/foundation.dart';
import '../data/easypaisa_contacts_data.dart';
import '../models/easypaisa_contact_model.dart';

/// ViewModel managing state for the Easypaisa Transfer flow.
class TransferViewModel extends ChangeNotifier {
  String _searchQuery = '';
  List<EasypaisaContactModel> _filteredContacts = [];
  EasypaisaContactModel? _selectedReceiver;
  String _amount = '0';
  String _optionalMessage = '';

  // Getters
  String get searchQuery => _searchQuery;
  List<EasypaisaContactModel> get filteredContacts => _filteredContacts;
  EasypaisaContactModel? get selectedReceiver => _selectedReceiver;
  String get amount => _amount;
  String get optionalMessage => _optionalMessage;

  bool get isAmountValid {
    final parsed = int.tryParse(_amount);
    return parsed != null && parsed > 0;
  }

  /// Update search query and filter contacts using Dart's .where()
  void onSearchQueryChanged(String query) {
    _searchQuery = query;
    _filteredContacts = filterContactsByQuery(query);
    notifyListeners();
  }

  /// Select a contact as receiver
  void selectReceiver(EasypaisaContactModel receiver) {
    _selectedReceiver = receiver;
    _amount = '0';
    _optionalMessage = '';
    notifyListeners();
  }

  /// Update the transfer amount
  void setAmount(String value) {
    final cleanDigits = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleanDigits.isEmpty) {
      _amount = '0';
    } else {
      // Remove leading zeros if any, e.g. "0500" -> "500"
      final parsed = int.tryParse(cleanDigits) ?? 0;
      _amount = parsed.toString();
    }
    notifyListeners();
  }

  /// Set optional message
  void setOptionalMessage(String message) {
    _optionalMessage = message;
    notifyListeners();
  }

  /// Reset state when leaving flow to prevent memory or stale data leaks
  void reset() {
    _searchQuery = '';
    _filteredContacts = [];
    _selectedReceiver = null;
    _amount = '0';
    _optionalMessage = '';
    notifyListeners();
  }
}
