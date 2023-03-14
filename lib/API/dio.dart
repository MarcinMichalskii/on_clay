import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:on_clay/API/APIParser.dart';
import 'package:on_clay/Models/calendar_data.dart';
import 'package:on_clay/API/time_helper.dart';

final Dio proxyDio = Dio();

class API {
  Future<void> setupHeaders() async {
    proxyDio.options.headers = {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET,PUT,PATCH,POST,DELETE',
      'Access-Control-Allow-Headers':
          'Origin, X-Requested-With, Content-Type, Accept',
    };
  }

  Future<void> setupProxy(Dio proxyDio) async {
    try {
      String proxy = 'localhost:9090';
      // ignore: inference_failure_on_function_invocation
      (proxyDio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
          (client) {
        client
          ..findProxy = (url) {
            return 'PROXY $proxy';
          };
      };
    } catch (_) {}
  }

  Future<void> login() async {
    try {
      final loginBody = {
        'login': 'test',
        'pass': 'test',
        'action': 'login',
        'back_url': '/pl/home.html'
      };
      FormData formData = FormData.fromMap(loginBody);
      final loginResponse = await proxyDio
          .post('https://www.twojtenis.pl/pl/login.html', data: formData,
              options: Options(
        validateStatus: (status) {
          if (status == null) {
            return false;
          }
          if (status == 302) {
            return true;
          }
          if (status >= 200 && status < 300) {
            return true;
          } else {
            return false;
          }
        },
      ));

      final cookies = loginResponse.headers['set-cookie'];
      final headers = {
        'Cookie': cookies,
      };
      proxyDio.options.headers = headers;
    } catch (e) {
      print(e);
    }
  }

  Future<String> getCalendar(DateTime date, String clubName) async {
    try {
      final formattedDate = TimeHelper().dateFormattedForAPI(date);
      final getCalendarBody = {'date': formattedDate, 'club_url': clubName};
      FormData calendarFormData = FormData.fromMap(getCalendarBody);
      final calendarResponse = await proxyDio.post(
        'https://www.twojtenis.pl/ajax.php?load=courts_list',
        data: calendarFormData,
      );
      final value =
          APIParser().parseItem(calendarResponse.data, CalendarData.fromJson);
      return value.schedule;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<String> getClubsList() async {
    try {
      final clubsResponse = await proxyDio.get(
        'https://www.twojtenis.pl/pl/kluby.html',
      );
      return clubsResponse.data;
    } catch (e) {
      return Future.error(e);
    }
  }
}
