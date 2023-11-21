import 'package:flutter/material.dart';

/// Custom button model.
class CustomButton {
  /// Action when you tap on the button.
  final VoidCallback? onTap;

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

  /// Create an instance CustomButton.
  CustomButton({
    this.onTap,
    this.text,
    this.textColor,
    this.textStyle,
    this.icon,
    this.pressedIcon,
    this.iconColor,
    this.iconSize,
    this.backgroundColor,
  });

  /// Create an instance [CustomButton] with modified parameters.
  CustomButton copyWith({
    VoidCallback? onTap,
    String? text,
    Color? textColor,
    TextStyle? textStyle,
    IconData? icon,
    IconData? pressedIcon,
    Color? iconColor,
    double? iconSize,
    Color? backgroundColor,
  }) {
    return CustomButton(
      onTap: onTap ?? this.onTap,
      text: text ?? this.text,
      textColor: textColor ?? this.textColor,
      textStyle: textStyle ?? this.textStyle,
      icon: icon ?? this.icon,
      pressedIcon: pressedIcon ?? this.pressedIcon,
      iconColor: iconColor ?? this.iconColor,
      iconSize: iconSize ?? this.iconSize,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }
}
