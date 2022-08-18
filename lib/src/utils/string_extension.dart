extension StringExtension on String {
  static String fromEnum(Object? o) => o.toString().split('.').last;

  T? toEnum<T>(List<T> values) {
    for (T value in values) {
      if (fromEnum(value) == this) return value;
    }
    return null;
  }
}
