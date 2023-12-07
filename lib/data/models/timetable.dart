class Timetable {
  final Map<String, String> schedules;

  Timetable({required this.schedules});

  // Factory method to create a Timetable from a map
  factory Timetable.fromMap(Map<String, dynamic> map) {
    var attributes = map['attributes'] as Map<String, dynamic>? ?? {};
    var locale = attributes['locale'] as String? ?? 'unknown';
    var schedule = attributes['schedule'] as String? ?? '';

    return Timetable(schedules: {locale: schedule});
  }

  // Static method to merge multiple Timetables into one
  static Timetable merge(List<Timetable> timetables) {
    var mergedSchedules = <String, String>{};
    for (var timetable in timetables) {
      mergedSchedules.addAll(timetable.schedules);
    }
    return Timetable(schedules: mergedSchedules);
  }

  // Static method to create a Timetable from the 'data' field
  static Timetable fromDataList(List<dynamic> dataList) {
    var allTimetables = dataList.map((dataItem) {
      var timetable = Timetable.fromMap(dataItem as Map<String, dynamic>);
      var localizations = (dataItem['attributes']['localizations']['data'] as List)
          .map((localization) => Timetable.fromMap(localization as Map<String, dynamic>))
          .toList();
      return [timetable, ...localizations];
    }).expand((x) => x).toList();

    return Timetable.merge(allTimetables);
  }
}