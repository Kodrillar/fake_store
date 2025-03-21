import 'package:dio/dio.dart';
import 'package:fake_store/src/core/utils/network_response.dart';
import 'package:fake_store/src/core/utils/service_locators.dart';
import 'package:fake_store/src/exceptions/app_exceptions.dart';
import 'package:fake_store/src/features/home/domain/product.dart';

class HomeRepository {
  Future<List<Product>> fetchProducts() async {
    try {
      final Response response = await getIt.get<Dio>().get('/products');

      final responseData = List<Map<String, dynamic>>.from(response.data);

      return responseData.map<Product>(Product.fromMap).toList();
    } on DioException catch (dioException) {
      final dioExceptionType = dioException.type;

      switch (dioExceptionType) {
        case DioExceptionType.badResponse:
          NetworkResponse.handleBadResponse(dioException.response!.statusCode!);
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
}
