import 'package:flutter/material.dart';

class PromoBannerModel {
  final String id;
  final String headline;
  final String? subheadline;
  final String? prizeAmount;
  final List<String> tagOffers;
  final List<Color> borderGradientColors;
  final LinearGradient backgroundGradient;
  final String? personImagePath;

  const PromoBannerModel({
    required this.id,
    required this.headline,
    this.subheadline,
    this.prizeAmount,
    this.tagOffers = const [],
    required this.borderGradientColors,
    required this.backgroundGradient,
    this.personImagePath,
  });
}
