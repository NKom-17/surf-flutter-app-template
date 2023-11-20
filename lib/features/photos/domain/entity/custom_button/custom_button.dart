import 'package:flutter/material.dart';
import 'package:flutter_template/features/photos/domain/entity/custom_button/custom_button_builder.dart';

/// Custom button model.
class CustomButton {
  final void Function()? _onTap;
  final String? _text;
  final Color? _textColor;
  final TextStyle? _textStyle;
  final IconData? _icon;
  final IconData? _pressedIcon;
  final Color? _iconColor;
  final double? _iconSize;
  final Color? _backgroundColor;

  /// Create an instance CustomButton.
  CustomButton(CustomButtonBuilder builder)
      : _onTap = builder.onTap,
        _text = builder.text,
        _textColor = builder.textColor,
        _textStyle = builder.textStyle,
        _icon = builder.icon,
        _pressedIcon = builder.pressedIcon,
        _iconColor = builder.iconColor,
        _iconSize = builder.iconSize,
        _backgroundColor = builder.backgroundColor;

  /// Get an action when you click on the button.
  void Function()? get onTap => _onTap;

  /// Get the text on the button.
  String? get text => _text;

  /// Get the color of the text on the button.
  Color? get textColor => _textColor;

  /// Get the text style on the button.
  TextStyle? get textStyle => _textStyle;

  /// Get the button icon.
  IconData? get icon => _icon;

  /// Get the button icon in the pressed state.
  IconData? get pressedIcon => _pressedIcon;

  /// Get the color of the button icon.
  Color? get iconColor => _iconColor;

  /// Get the size of the button icon.
  double? get iconSize => _iconSize;

  /// Get the background color of the button.
  Color? get backgroundColor => _backgroundColor;
}
