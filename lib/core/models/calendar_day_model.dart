class CalendarDayModel {
  final int day;
  final bool inMonth;
  final bool isSelected;
  final bool hasActivity;

  const CalendarDayModel({
    required this.day,
    required this.inMonth,
    this.isSelected = false,
    this.hasActivity = false,
  });
}
