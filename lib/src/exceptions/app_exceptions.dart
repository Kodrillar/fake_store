sealed class AppException {
  String get message;

  @override
  String toString() {
    return message;
  }
}

class BadResponseException extends AppException {
  @override
  String get message => 'Sorry, Something went wrong.';
}

class UnexpectedException extends AppException {
  @override
  String get message => 'Sorry, an unexpected error occured.';
}

class InvalidAuthCredentialsException extends AppException {
  @override
  String get message => 'Invalid username or password.';
}

class AppSocketException extends AppException {
  @override
  String get message => 'No internet connection.';
}
