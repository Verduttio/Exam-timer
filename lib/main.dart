import 'package:flutter/material.dart';
import 'package:timer_app/pages/time_measure.dart';
import 'package:timer_app/pages/insert_data.dart';

import 'package:desktop_window/desktop_window.dart';  // for windows app only
import 'dart:io';  // for windows application only

void main()  {
  runApp(MaterialApp(
    initialRoute: '/insert',
    routes: {
      '/insert': (context) => Inserting(),
      '/timer': (context) => TimeMeasure(),
    }
  ));
  // FOR WINDOWS APP ONLY
  if (Platform.isWindows) {
    DesktopWindow.setWindowSize(Size(440, 650));
    DesktopWindow.setMinWindowSize(Size(350, 600));
  }
  // END OF FOR WINDOWS APP ONLY
}
