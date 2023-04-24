class Validator {

  static String? validateName(String name) {

    if (name.isEmpty) {
      return 'Name can\'t be empty';
    }
    else{
      return '';
    }
  }

  static String? validateEmail(String email) {

    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    if (email.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Enter a correct email';
    }
    else{
      return '';
    }
  }

  static String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password can\'t be empty';
    } else if (password.length < 6) {
      return 'Enter a password with length at least 6';
    }
    else{
      return '';
    }
  }


  static String? validateConfirmPassword(String confirmPassword, String password) {
    print(password);
    if (confirmPassword.isEmpty) {
      return 'Confirm password can\'t be empty';
    } else if (confirmPassword != password) {
      return 'Passwords do not match';
    } else {
      return '';
    }
  }
}
