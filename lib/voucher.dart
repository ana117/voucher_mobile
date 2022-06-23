import 'package:flutter/material.dart';

@immutable
class Voucher {
  final String code;
  final String description;
  final bool status;

  const Voucher(this.code, this.description, this.status);
}