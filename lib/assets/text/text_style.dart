//ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

/// App text style.
enum AppTextStyle {
  regular12(TextStyle(fontSize: 12, height: 1.5)),
  regular14(TextStyle(fontSize: 14, height: 1.40)),
  regular16(TextStyle(fontSize: 16, height: 1.24)),

  medium14(TextStyle(fontSize: 14, height: 1.40, fontWeight: FontWeight.w500)),
  medium16(TextStyle(fontSize: 16, height: 1.24, fontWeight: FontWeight.w500)),

  bold12(TextStyle(fontSize: 12, height: 1.5, fontWeight: FontWeight.w700)),
  bold14(TextStyle(fontSize: 14, height: 1.40, fontWeight: FontWeight.w700)),
  bold16(TextStyle(fontSize: 16, height: 1.24, fontWeight: FontWeight.w700)),
  bold20(TextStyle(fontSize: 20, height: 1.15, fontWeight: FontWeight.w700));

  final TextStyle value;

  const AppTextStyle(this.value);
}
