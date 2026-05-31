import 'package:flutter/material.dart';

class Responsive {
  Responsive._();

  static bool isSmall(BuildContext context) => MediaQuery.of(context).size.width < 360;
  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 600;
  static bool isTablet(BuildContext context) => MediaQuery.of(context).size.width >= 600 && MediaQuery.of(context).size.width < 1024;
  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1024;
}
