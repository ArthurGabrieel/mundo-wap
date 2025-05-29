import 'package:flutter/material.dart';

import 'app_widget.dart';
import 'core/config/injection/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.initDependecies();
  runApp(const MundoWapApp());
}
