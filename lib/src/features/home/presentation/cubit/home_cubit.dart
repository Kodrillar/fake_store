import 'package:fake_store/src/core/utils/async_state.dart';
import 'package:fake_store/src/core/utils/service_locators.dart';
import 'package:fake_store/src/features/home/data/home_repository.dart';
import 'package:fake_store/src/features/home/domain/product.dart';
import 'package:fake_store/src/features/home/presentation/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial());

  Future<void> fetchProducts() async {
    emit(state.copyWith(asyncState: AsyncLoading()));

    try {
      final List<Product> products =
          await getIt.get<HomeRepository>().fetchProducts();

      print('Cubit prods;==========> $products');

      emit(state.copyWith(asyncState: AsyncData<List<Product>>(products)));
    } catch (ex) {
      print('Cubit ex:======== $ex');
      emit(state.copyWith(asyncState: AsyncError(ex)));
    }
  }
}
