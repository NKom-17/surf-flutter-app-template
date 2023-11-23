import 'package:flutter/material.dart';
import 'package:flutter_template/features/photos/domain/entity/custom_button/custom_button.dart';

/// A class for creating instances of custom buttons.
class CustomButtonBuilder {
  var _customButton = const CustomButton();

  /// Create an instance CustomButtonBuilder.
  CustomButtonBuilder();

  /// Set the action when you tap on the button.
  void setOnTap(VoidCallback onTap) {
    _customButton = _customButton.copyWith(onTap: onTap);
  }

  /// Set parameters for the button text.
  void setText(
    String text, {
    Color? textColor,
    TextStyle? textStyle,
  }) {
    _customButton = _customButton.copyWith(
      text: text,
      textColor: textColor,
      textStyle: textStyle,
    );
  }

  /// Set parameters for the button icon.
  void setIcon(
    IconData icon, {
    IconData? pressedIcon,
    Color? iconColor,
    double? iconSize,
  }) {
    _customButton = _customButton.copyWith(
      icon: icon,
      pressedIcon: pressedIcon,
      iconColor: iconColor,
      iconSize: iconSize,
    );
  }

  /// Set the background color parameter of the button.
  void setBackgroundColor(Color backgroundColor) {
    _customButton = _customButton.copyWith(backgroundColor: backgroundColor);
  }

  /// Creating an instance [CustomButton]
  CustomButton toBuild() {
    return _customButton;
  }
}
