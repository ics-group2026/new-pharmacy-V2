/// A `{ "en": ..., "ar": ... }` translation object as returned by the API.
///
/// Tolerates a plain string (the backend sends one when a field has no
/// translations) and null, so callers never crash on shape drift.
class LocalizedText {
  final String? en;
  final String? ar;

  const LocalizedText({this.en, this.ar});

  factory LocalizedText.fromJson(dynamic json) {
    if (json is Map) {
      return LocalizedText(en: json['en'] as String?, ar: json['ar'] as String?);
    }
    if (json is String) return LocalizedText(en: json, ar: json);
    return const LocalizedText();
  }

  /// Resolves the text for [languageCode], falling back to the other language
  /// so a missing translation still shows something.
  String localized(String languageCode) {
    final value = languageCode == 'ar' ? ar : en;
    return value ?? en ?? ar ?? '';
  }
}
