// ignore_for_file: unused_field

import 'dart:developer' as developer;

class Log {
  static void print(dynamic m1, [dynamic m2 = '', dynamic m3 = '', dynamic m4 = '', dynamic m5 = '']) {
    String message = '$m1 $m2 $m3 $m4 $m5';
    developer.log(_LogColors.white + message + _LogColors.reset, name: '${_LogColors.white}PRINT${_LogColors.reset}');
  }

  static void error(dynamic m1, [dynamic m2 = '', dynamic m3 = '', dynamic m4 = '', dynamic m5 = '']) {
    String message = '$m1 $m2 $m3 $m4 $m5';
    developer.log(_LogColors.red + message + _LogColors.reset, name: '${_LogColors.red}ERROR${_LogColors.reset}');
  }

  static void success(dynamic m1, [dynamic m2 = '', dynamic m3 = '', dynamic m4 = '', dynamic m5 = '']) {
    String message = '$m1 $m2 $m3 $m4 $m5';
    developer.log(_LogColors.green + message + _LogColors.reset, name: '${_LogColors.green}SUCCESS${_LogColors.reset}');
  }

  static void info(dynamic m1, [dynamic m2 = '', dynamic m3 = '', dynamic m4 = '', dynamic m5 = '']) {
    String message = '$m1 $m2 $m3 $m4 $m5';
    developer.log(_LogColors.yellow + message + _LogColors.reset, name: '${_LogColors.yellow}INFO${_LogColors.reset}');
  }
}

class _LogColors {
  static const String reset = '\x1B[0m';
  static const String black = '\x1B[30m';
  static const String white = '\x1B[37m';
  static const String red = '\x1B[91m';
  static const String green = '\x1B[32m';
  static const String yellow = '\x1B[33m';
  static const String blue = '\x1B[34m';
  static const String cyan = '\x1B[36m';
}
