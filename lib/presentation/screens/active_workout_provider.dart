import 'package:flutter/foundation.dart';

class ActiveWorkoutProvider extends ChangeNotifier {
  bool isPaused = false;

  void togglePause() {
    isPaused = !isPaused;
    notifyListeners();
  }
}
