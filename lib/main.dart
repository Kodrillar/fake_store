import 'package:fake_store/src/app.dart';
import 'package:fake_store/src/core/utils/service_locators.dart';
import 'package:fake_store/src/features/auth/data/repository/auth.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  ServiceLocators.register();

  getIt
      .allReady()
      .then((_) => getIt.get<AuthRepository>().initializeCurrentUser());

  runApp(const FakeStoreApp());
}
