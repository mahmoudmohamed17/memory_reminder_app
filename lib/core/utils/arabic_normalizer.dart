/// Makes Arabic text searchable: the same word typed in different
/// forms (أ/إ/ا, ة/ه, ى/ي, with/without harakat) matches.
abstract final class ArabicNormalizer {
  static final _diacritics = RegExp('[\u064B-\u0652\u0670\u0640]'); // harakat + tatweel
  static final _alef = RegExp('[أإآٱ]');
  static const _easternDigits = '٠١٢٣٤٥٦٧٨٩';

  static String normalize(String input) {
    var s = input.toLowerCase().replaceAll(_diacritics, '');
    s = s
        .replaceAll(_alef, 'ا')
        .replaceAll('ى', 'ي')
        .replaceAll('ة', 'ه');
    for (var i = 0; i < _easternDigits.length; i++) {
      s = s.replaceAll(_easternDigits[i], '$i');
    }
    return s.trim();
  }
}