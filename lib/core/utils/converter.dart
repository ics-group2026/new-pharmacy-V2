class Converter {
  static num? toNumOrNull(dynamic value) {
    if (value == null) return null;
    if (value is num) return value;
    if (value is String) return num.tryParse(value);
    return null;
  }

  static double? toDoubleOrNull(dynamic value) {
    return toNumOrNull(value)?.toDouble();
  }

  static int? toIntOrNull(dynamic value) {
    return toNumOrNull(value)?.toInt();
  }
}
