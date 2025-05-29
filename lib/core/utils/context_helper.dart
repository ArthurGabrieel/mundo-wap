import 'package:flutter/material.dart';

import '../config/theme/colors.dart';

extension ContextHelper on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  void showSnackBar(String message, {Color color = colorError}) {
    ScaffoldMessenger.of(
      this,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }
}
