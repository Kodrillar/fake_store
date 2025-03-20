import 'package:dio/dio.dart';
import 'package:fake_store/src/core/utils/service_locators.dart';
import 'package:fake_store/src/exceptions/app_exceptions.dart';
import 'package:fake_store/src/features/auth/domain/login_data.dart';

class AuthNetworkHelper {
  Future<String> logIn(LoginData login) async {
    try {
      final Response response = await getIt.get<Dio>().post(
            '/auth/login',
            data: login.toJson(),
          );

      final responseData = response.data as Map;

      return responseData['token'];
    } on DioException catch (dioException) {
      final dioExceptionType = dioException.type;

      switch (dioExceptionType) {
        case DioExceptionType.badResponse:
          _handleBadResponse(dioException.response!.statusCode!);
          break;

        case DioExceptionType.connectionError:
          throw AppSocketException();

        default:
          throw BadResponseException();
      }
    } catch (ex) {
      throw UnexpectedException();
    }

    throw UnexpectedException();
  }

  void _handleBadResponse(int statusCode) {
    switch (statusCode) {
      case 401:
        throw InvalidAuthCredentialsException();
      default:
        throw BadResponseException();
    }
  }
}
