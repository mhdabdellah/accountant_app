class Validator {
  static String? isEmpty(String? value) {
    if (value != null && value.isEmpty) {
      return "cannot be empty";
    }
    return null;
  }

  static String? isEmailValid(String? email) {
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.[a-zA-Z]{2,}$");

    if (email != null && emailRegex.hasMatch(email)) {
      return null;
    } else {
      return 'Invalid email format';
    }
  }

  static String? isPasswordValid(String? password) {
    if (password != null && password.length >= 8) {
      return null;
    } else {
      return 'Password must meet strength requirements';
    }
  }
}
