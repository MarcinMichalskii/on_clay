import 'package:html/parser.dart' show parse;
import 'package:on_clay/clubs_data.dart';

class ClubsHelper {
  static List<ClubData> handleClubsList(String htmlData) {
    var document = parse(htmlData);
    final clubsBoxes = document.getElementsByClassName("favbox");
    final clubsData = clubsBoxes.map((element) {
      final clubUrl =
          element.getElementsByClassName('club_map').first.attributes["href"] ??
              '';
      final clubPath = extractPath(clubUrl);
      final clubName = element.attributes['title'] ?? '';

      return ClubData(clubName, clubPath);
    }).toList();
    return clubsData;
  }

  static String extractPath(String data) {
    if (data.isEmpty) {
      return '';
    }
    String trimmed = data.substring(1, data.length - 5);
    List<String> parts = trimmed.split('/');
    return parts.last;
  }
}
