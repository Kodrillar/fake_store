class TextFieldValidators {
  static String? generic(String? textFieldText) {
    if (textFieldText != null) {
      if (textFieldText.isEmpty) {
        return 'Kindly fill in this field';
      }
    }

    return null;
  }
}
