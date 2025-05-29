import 'dart:developer' as developer;

import 'package:logger/logger.dart';

final log = Logger(
  printer: PrettyPrinter(methodCount: 0, lineLength: 110),
  output: MyConsoleOutput(),
  level: Level.debug,
);

class MyConsoleOutput extends ConsoleOutput {
  @override
  void output(OutputEvent event) => event.lines.forEach(developer.log);
}
