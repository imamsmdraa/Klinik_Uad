import 'package:flutter/material.dart';

import '../features/home/presentation/pages/home_page.dart';

abstract final class AppRouter {
  static const home = '/';

  static final routes = <String, WidgetBuilder>{
    home: (_) => const HomePage(),
  };
}
