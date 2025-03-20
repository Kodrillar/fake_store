import 'package:fake_store/src/exceptions/app_exceptions.dart';

class NetworkResponse {
  static void handleBadResponse(int statusCode) {
    switch (statusCode) {
      case 401:
        throw InvalidAuthCredentialsException();
      default:
        throw BadResponseException();
    }
  }
}
