import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  /// 🔹 MediaQuery shortcuts
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  EdgeInsets get padding => MediaQuery.of(this).padding;
  double get statusBarHeight => MediaQuery.of(this).padding.top;

  /// 🔹 Theme shortcuts
  ThemeData get theme => Theme.of(this);
  TextTheme get appTextTheme => Theme.of(this).textTheme;
  IconThemeData get iconTheme => Theme.of(this).iconTheme;
  IconButtonThemeData get iconButtonTheme => Theme.of(this).iconButtonTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// 🔹 Navigation helpers
  void push(Widget page) =>
      Navigator.of(this).push(MaterialPageRoute(builder: (_) => page));

  void pushReplacement(Widget page) =>
      Navigator.of(this).pushReplacement(MaterialPageRoute(builder: (_) => page));

  void pushAndRemoveUntil(Widget page) =>
      Navigator.of(this).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => page),
        (route) => false,
      );

  void pop<T extends Object?>([T? result]) => Navigator.of(this).pop(result);

  /// 🔹 SnackBar helpers
  void showSnackBar(String message, {Color? background}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: background ?? theme.colorScheme.primary,
      ),
    );
  }

  /// 🔹 Dialog helpers
  Future<T?> showDialogBox<T>({
    required Widget child,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: this,
      barrierDismissible: barrierDismissible,
      builder: (_) => child,
    );
  }

  /// 🔹 Show bottom sheet
  Future<T?> showBottomSheetWidget<T>({
    required Widget child,
    bool isScrollControlled = true,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      builder: (_) => child,
    );
  }
}

