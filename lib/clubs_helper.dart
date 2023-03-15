import 'package:html/parser.dart' show parse;
import 'package:on_clay/Models/clubs_data.dart';

class ClubsParser {
  static List<ClubData> parseFromHtml(String htmlData) {
    var document = parse(htmlData);
    final clubsBoxes = document.getElementsByClassName("favbox");
    final clubsData = clubsBoxes.map((element) {
      final clubUrl =
          element.getElementsByClassName('club_map').first.attributes["href"] ??
              '';
      final clubPath = _extractPath(clubUrl);
      final clubName = element.attributes['title'] ?? '';

      final clubAddress =
          element.getElementsByClassName('normal').first.innerHtml;
      final cleanedClubAddress = _removeRegionFromAddress(clubAddress);
      final splitAddress = cleanedClubAddress.split("<br>");

      return ClubData(
          clubName: clubName,
          clubPath: clubPath,
          street: splitAddress[0],
          addressDetails: splitAddress[1].replaceAll(",", ""),
          fetchedSchedules: {});
    }).toList();
    return clubsData;
  }

  static String _extractPath(String data) {
    if (data.isEmpty) {
      return '';
    }
    String trimmed = data.substring(1, data.length - 5);
    List<String> parts = trimmed.split('/');
    return parts.last;
  }

  static String _extractAddress(String data) {
    return '';
  }

  static String _removeRegionFromAddress(String address) {
    int startIndex = address.indexOf("woj. ");

    if (startIndex == -1) {
      return address;
    }

    int endIndex = address.indexOf(" ", startIndex + 5);

    if (endIndex == -1) {
      endIndex = address.length;
    }

    String addressWithoutRegion =
        address.replaceRange(startIndex, endIndex, "");

    return addressWithoutRegion.trim();
  }
}
