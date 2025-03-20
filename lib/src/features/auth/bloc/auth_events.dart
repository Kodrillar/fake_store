import 'package:equatable/equatable.dart';

sealed class AuthEvent extends Equatable {}

class ObscureTextEvent extends AuthEvent {
  ObscureTextEvent(this.shouldObscure) : super();
  final bool shouldObscure;

  @override
  List<Object?> get props => [shouldObscure];
}

class LoadingEvent extends AuthEvent {
  LoadingEvent() : super();

  @override
  List<Object?> get props => [];
}

class ErrorEvent extends AuthEvent {
  ErrorEvent(this.error) : super();

  final dynamic error;

  @override
  List<Object?> get props => [];
}

class DataEvent extends AuthEvent {
  DataEvent(this.data) : super();

  final dynamic data;

  @override
  List<Object?> get props => [];
}
