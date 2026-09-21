import 'package:flutter/material.dart';

/// Data model representing a transfer destination option in the "Send Money To" dialog.
class SendMoneyOptionModel {
  final String id;
  final String title;
  final String imageAsset;
  final VoidCallback? onTap;

  const SendMoneyOptionModel({
    required this.id,
    required this.title,
    this.imageAsset = 'assets/images_orig/easypaisa_logo.png',
    this.onTap,
  });

  /// Default list of 6 Send Money options matching the official Easypaisa UI.
  /// Note: All items default to 'assets/images_orig/easypaisa_logo.png' as requested.
  /// You can easily change the imageAsset path for each item later when ready.
  static List<SendMoneyOptionModel> get defaultOptions => [
    const SendMoneyOptionModel(
      id: 'easypaisa_transfer',
      title: 'easypaisa\nTransfer',
      imageAsset: 'assets/images_orig/easypaisamainlogo.png',
    ),
    const SendMoneyOptionModel(
      id: 'bank_transfer',
      title: 'Bank\nTransfer',
      // Change to 'assets/images_orig/banktransafer.jpeg' when ready:
      imageAsset: 'assets/images_orig/banktransafer.jpeg',
    ),
    const SendMoneyOptionModel(
      id: 'cnic_transfer',
      title: 'CNIC\nTransfer',
      // Change to 'assets/images_orig/cnic.jpeg' when ready:
      imageAsset: 'assets/images_orig/cnic.jpeg',
    ),
    const SendMoneyOptionModel(
      id: 'raast_payment',
      title: 'Raast\nPayment',
      // Change to 'assets/images_orig/raast.jpeg' when ready:
      imageAsset: 'assets/images_orig/raast.jpeg',
    ),
    const SendMoneyOptionModel(
      id: 'other_wallets',
      title: 'Other Wallets',
      // Change to 'assets/images_orig/wallets.jpeg' when ready:
      imageAsset: 'assets/images_orig/wallets.jpeg',
    ),
    const SendMoneyOptionModel(
      id: 'scan_qr',
      title: 'Scan QR',
      // Change to 'assets/images_orig/qrscan.jpeg' when ready:
      imageAsset: 'assets/images_orig/qrscan.jpeg',
    ),
  ];
}
