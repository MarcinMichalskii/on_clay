class HtmlElementHelper {
  static int extractHeight(String inputString) {
    final regex = RegExp(r'style=".*?height:(\d+)px');
    final match = regex.firstMatch(inputString);
    if (match != null) {
      final value = match.group(1);
      return int.parse(value ?? '');
    } else {
      throw Exception('Height not found in input string');
    }
  }

  static String extractHeaderTitle(String text) {
    RegExp regex = RegExp(r'<strong>(.*?)</strong>');
    Match? match = regex.firstMatch(text);
    String? result = match?.group(1);
    return result ?? '';
  }
}
