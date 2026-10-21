import 'package:fitness_app/core/app_data.dart';
import 'package:flutter/foundation.dart';

class ActivityProvider extends ChangeNotifier {
  int selectedDayIndex = AppData.calendarDays.indexWhere((day) => day.isSelected);

  void selectDay(int index) {
    if (selectedDayIndex == index) return;
    selectedDayIndex = index;
    notifyListeners();
  }
}
