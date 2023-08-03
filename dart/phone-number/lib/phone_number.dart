// Clean up a phone number so it can be used.
// https://exercism.org/tracks/dart/exercises/phone-number

class PhoneNumber {
  String clean(String number) {
    RegExp re_exp = RegExp(r"[- .;!@#$%^&*_+=}{`~><?)(]");
    String new_number = number.replaceAll(re_exp, '');

    if (RegExp(r'[a-zA-Z]').hasMatch(number)) {
      throw FormatException('letters not permitted');
    }

    if (RegExp(r"[[:punct:]]").hasMatch(number)) {
      throw FormatException('punctuations not permitted');
    }

    if (new_number.length < 10) {
      throw FormatException('incorrect number of digits');
    }

    if (new_number.length > 11) {
      throw FormatException('more than 11 digits');
    }

    if (new_number.length == 11 && new_number[0] != '1') {
      throw FormatException('11 digits must start with 1');
    }

    if (new_number.length == 11) {
      new_number = new_number.substring(1);
    }

    if (new_number[1] == '0') {
      throw FormatException('area code cannot start with 0');
    }

    if (new_number[1] == '1') {
      throw FormatException('area code cannot start with 1');
    }

    if (new_number[3] == '0') {
      throw FormatException('exchange code cannot start with 0');
    }

    if (new_number[3] == '1') {
      throw FormatException('exchange code cannot start with 1');
    }

    return new_number;
  }
}
