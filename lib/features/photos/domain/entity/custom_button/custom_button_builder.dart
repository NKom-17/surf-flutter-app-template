import 'package:flutter/material.dart';
import 'package:flutter_template/features/photos/domain/entity/custom_button/custom_button.dart';

/// A class for creating instances of custom buttons.
class CustomButtonBuilder {
  /// Action when you click on the button.
  final void Function() onTap;

  /// The text on the button.
  final String? text;

  /// The color of the text on the button.
  final Color? textColor;

  /// The text style on the button.
  final TextStyle? textStyle;

  /// The button icon.
  final IconData? icon;

  /// The button icon in the pressed state.
  final IconData? pressedIcon;

  /// The color of the button icon.
  final Color? iconColor;

  /// The size of the button icon.
  final double? iconSize;

  /// The background color of the button.
  final Color? backgroundColor;

  /// Create an instance CustomButtonBuilder.
  CustomButtonBuilder(
    this.onTap, {
    this.text,
    this.textColor,
    this.textStyle,
    this.icon,
    this.pressedIcon,
    this.iconColor,
    this.iconSize,
    this.backgroundColor,
  });

  /// Creating an instance [CustomButton]
  CustomButton toBuild() {
    return CustomButton(this);
  }
}
