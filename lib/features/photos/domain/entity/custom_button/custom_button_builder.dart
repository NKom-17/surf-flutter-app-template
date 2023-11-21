import 'package:flutter/material.dart';
import 'package:flutter_template/features/photos/domain/entity/custom_button/custom_button.dart';

/// A class for creating instances of custom buttons.
class CustomButtonBuilder {
  final void Function() _onTap;
  String? _text;
  Color? _textColor;
  TextStyle? _textStyle;
  IconData? _icon;
  IconData? _pressedIcon;
  Color? _iconColor;
  double? _iconSize;

  /// The background color of the button.
  Color? backgroundColor;

  /// Create an instance CustomButtonBuilder.
  CustomButtonBuilder(this._onTap);

  /// Set parameters for the button text.
  void setText(
    String text, {
    Color? textColor,
    TextStyle? textStyle,
  }) {
    _text = text;
    _textColor = textColor;
    _textStyle = textStyle;
  }

  /// Set parameters for the button icon.
  void setIcon(
    IconData icon, {
    IconData? pressedIcon,
    Color? iconColor,
    double? iconSize,
  }) {
    _icon = icon;
    _pressedIcon = pressedIcon;
    _iconColor = iconColor;
    _iconSize = iconSize;
  }

  /// Creating an instance [CustomButton]
  CustomButton toBuild() {
    return CustomButton().copyWith(
      onTap: _onTap,
      text: _text,
      textColor: _textColor,
      textStyle: _textStyle,
      icon: _icon,
      pressedIcon: _pressedIcon,
      iconColor: _iconColor,
      iconSize: _iconSize,
      backgroundColor: backgroundColor,
    );
  }
}
