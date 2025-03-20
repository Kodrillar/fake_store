import 'package:equatable/equatable.dart';

sealed class AsyncState extends Equatable {
  bool get isLoading;
  bool get hasError;
}

final class AsyncLoading extends AsyncState {
  @override
  List<Object?> get props => [];

  @override
  bool get isLoading => true;

  @override
  bool get hasError => false;

  @override
  String toString() {
    return 'AsyncLoading()';
  }
}

final class AsyncData<T> extends AsyncState {
  AsyncData(this.data) : super();

  final T? data;

  @override
  bool get isLoading => false;

  @override
  List<Object?> get props => [data];

  @override
  bool get hasError => false;

  @override
  String toString() {
    return 'AsyncData(data: $data)';
  }
}

final class AsyncError<T> extends AsyncState {
  AsyncError(this.error) : super();

  final T error;

  @override
  bool get isLoading => false;

  @override
  List<Object?> get props => [error];

  @override
  bool get hasError => true;

  @override
  String toString() {
    return 'AsyncError(error: $error)';
  }
}
