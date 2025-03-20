import 'package:flutter/material.dart';

import 'package:fake_store/src/core/utils/async_state.dart';

ValueNotifier<int> navIndexNotifier = ValueNotifier(0);

class HomeState {
  final AsyncState asyncState;
  HomeState({
    required this.asyncState,
  });

  factory HomeState.initial() => HomeState(asyncState: AsyncData(const []));

  @override
  String toString() => 'HomeState(asyncState: $asyncState)';

  HomeState copyWith({
    AsyncState? asyncState,
  }) {
    return HomeState(
      asyncState: asyncState ?? this.asyncState,
    );
  }
}
