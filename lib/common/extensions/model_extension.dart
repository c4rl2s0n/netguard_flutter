
import 'package:flutter/material.dart';
import 'package:netguard/data/data.dart';

extension ApplicationExtension on Application{
  Image? get image => icon != null ? Image.memory(icon!) : null;
}