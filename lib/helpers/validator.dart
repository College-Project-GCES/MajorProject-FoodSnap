validator({
  required List<String> validations,
  required String value,
  required int length,
}) {
  bool isValidate = true;
  String message = '';

  for (String element in validations) {
    switch (element) {
      case 'length':
        if (value.length < length) {
          isValidate = false;
          message = "The length must be at least $length";
        }
        break;
      case 'specific-length':
        if (value.length != length) {
          isValidate = false;
          message = "The length must be $length";
        }
        break;
      case 'secure':
        if (!value.contains(RegExp(r'[0-9]'))) {
          isValidate = false;
          message = "Must contain at least one number";
        }
        break;
      case 'email':
        if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
          isValidate = false;
          message = "Provided email is not valid";
        }
        break;
      default:
        return true;
    }
    if (!isValidate) {
      break;
    }
  }
  return {
    'isValidate': isValidate,
    'message': message,
  };
}
