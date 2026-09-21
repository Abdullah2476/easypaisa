import 'package:flutter/material.dart';

class ActionItemModel {
  final String id;
  final String title;
  final IconData? icon;
  final String? customIconKey;
  final String? badgeText;
  final Color? badgeColor;
  final Color? iconColor;
  final Color? iconBgColor;

  const ActionItemModel({
    required this.id,
    required this.title,
    this.icon,
    this.customIconKey,
    this.badgeText,
    this.badgeColor,
    this.iconColor,
    this.iconBgColor,
  });
}
