import 'package:flutter/material.dart';

class DebitCardModel {
  final String id;
  final String title;
  final String subtitle;
  final Color backgroundColor;
  final bool hasChip;
  final String buttonText;

  const DebitCardModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
    this.hasChip = false,
    this.buttonText = "Manage card",
  });
}
