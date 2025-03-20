import 'package:fake_store/src/core/utils/async_state.dart';
import 'package:fake_store/src/core/utils/service_locators.dart';
import 'package:fake_store/src/features/auth/bloc/auth_events.dart';
import 'package:fake_store/src/features/auth/bloc/auth_state.dart';
import 'package:fake_store/src/features/auth/data/repository/auth.dart';
import 'package:fake_store/src/features/auth/domain/login_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.initial()) {
    on<ObscureTextEvent>((event, emit) {
      final newState = _updateObscureState(event.shouldObscure);
      emit(newState);
    });

    on<ErrorEvent>((event, emit) {
      emit(state.copyWith(asyncState: AsyncError(event.error)));
    });

    on<LoadingEvent>((event, emit) {
      emit(state.copyWith(asyncState: AsyncLoading()));
    });

    on<DataEvent>((event, emit) {
      emit(state.copyWith(asyncState: AsyncData(event.data)));
    });
  }

  void logIn(LoginData loginData) async {
    add(LoadingEvent());
    try {
      await getIt.get<AuthRepository>().logIn(loginData);
      add(DataEvent(null));
    } catch (ex) {
      add(ErrorEvent(ex));
    }
  }

  void logOut() async {
    try {
      await getIt.get<AuthRepository>().logOut();
    } catch (ex) {
      add(ErrorEvent(ex));
    }
  }

  AuthState _updateObscureState(bool shouldObscureText) =>
      state.copyWith(obscureText: shouldObscureText);
}
