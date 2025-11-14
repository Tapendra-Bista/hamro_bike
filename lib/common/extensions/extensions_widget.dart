import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  //   /// Adds symmetric padding
  Widget appPaddingSymmetric({double h = 0, double v = 0}) => Padding(
    padding: .symmetric(horizontal: h, vertical: v),
    child: this,
  );

  /// Adds padding to all sides
  Widget appPaddingAll(double value) =>
      Padding(padding: .all(value), child: this);

  // // Adds padding only to specified sides
  Widget appPaddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) => Padding(
    padding: .only(left: left, top: top, right: right, bottom: bottom),
    child: this,
  );
  //   /// Adds margin using Container
  //   Widget marginAll(double value) =>
  //       Container(margin: .all(value), child: this);

  //   /// Adds symmetric margin
  //   Widget marginSymmetric({double h = 0, double v = 0}) =>
  //       Container(
  //         margin: .symmetric(horizontal: h, vertical: v),
  //         child: this,
  //       );

  //   /// Centers the widget
  Widget center() => Center(child: this);

  //   /// Expands to full available width
  //   Widget expand() => Expanded(child: this);

  //   /// Adds rounded corners
  Widget rounded(double radius) =>
      ClipRRect(borderRadius: .circular(radius), child: this);

  //   /// Adds background color
  //   Widget backgroundColor(Color color) =>
  //       Container(color: color, child: this);

  //   /// Adds tap gesture
  //   Widget onTap(VoidCallback onTap) =>
  //       GestureDetector(onTap: onTap, child: this);

  //   /// Makes widget scrollable vertically
  //   Widget scrollable() => SingleChildScrollView(child: this);

  //   /// Aligns the widget
  //   Widget align(Alignment alignment) =>
  //       Align(alignment: alignment, child: this);

  /// Wraps with SafeArea
  Widget safe() => SafeArea(child: this);

  //   /// Wraps with Visibility
  //   Widget visible(bool isVisible) =>
  //       Visibility(visible: isVisible, child: this);

  //   /// Wraps with SizedBox with custom height
  Widget height(double height) => SizedBox(height: height, child: this);

  //   /// Wraps with SizedBox with custom width
  Widget width(double width) => SizedBox(width: width, child: this);

  //   /// Adds box decoration (useful for background + rounded)
  //   Widget decorated({
  //     Color? color,
  //     double radius = 0,
  //     BoxBorder? border,
  //     BoxShadow? shadow,
  //   }) =>
  //       Container(
  //         decoration: BoxDecoration(
  //           color: color,
  //           border: border,
  //           borderRadius: BorderRadius.circular(radius),
  //           boxShadow: shadow != null ? [shadow] : null,
  //         ),
  //         child: this,
  //       );
}
