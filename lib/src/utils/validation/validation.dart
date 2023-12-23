class Validation {
  static String? validatePassword(String? password) {
    List<String> symbols = ["@", "#", "\$", "!", "*", "&", "^"];
    var integers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0];

    bool symbolsTrue = symbols.any((element) => password!.contains(element));
    bool integersTrue =
        integers.any((element) => password!.contains(element.toString()));

    return password!.isNotEmpty
        ? password.length > 8 && symbolsTrue && integersTrue
            ? null
            : 'Invalid Password'
        : null;
  }

  static String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  static String? validateMobile(String? value) {
    if (value!.length != 10 && value.isNotEmpty) {
      return 'Mobile Number must be of 10 digit';
    } else {
      return null;
    }
  }

  static String? validateUrl(String? value) {
    const pattern =
        r'^(?:http|https):\/\/(?:www\.)?[a-zA-Z0-9-]+(?:\.[a-zA-Z]{2,})+(?:\/[^\s]*)?$';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? "Enter a valid url"
        : null;
  }
}
