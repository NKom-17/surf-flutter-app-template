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

  /// Action when you click on the button.
  void Function() get onTap => _onTap;

  /// The text on the button.
  String? get text => _text;

  /// The color of the text on the button.
  Color? get textColor => _textColor;

  /// The text style on the button.
  TextStyle? get textStyle => _textStyle;

  /// The button icon.
  IconData? get icon => _icon;

  /// The button icon in the pressed state.
  IconData? get pressedIcon => _pressedIcon;

  /// The color of the button icon.
  Color? get iconColor => _iconColor;

  /// The size of the button icon.
  double? get iconSize => _iconSize;

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
    return CustomButton(this);
  }
}
