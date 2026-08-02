import 'package:flutter/material.dart';

class CouponModel {
  final String id;
  final String storeName;
  final String discount;
  final String code;
  final String category;
  final Color color;

  CouponModel({
    required this.id,
    required this.storeName,
    required this.discount,
    required this.code,
    required this.category,
    required this.color,
  });
}