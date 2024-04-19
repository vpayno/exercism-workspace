class Luhn {
  bool valid(String code) {
    print("code: $code");

    List<String> runes = code.split('');

    if (!code.contains(RegExp(r'^[0-9 ]+$'))) {
      print("ERROR: invalid characters");

      return false;
    }

    List<String> filtered =
        runes.where((item) => item.contains(RegExp(r'^[0-9]$'))).toList();

    print("filtered code: $filtered");

    List<int> digits = filtered.map((item) => int.parse(item)).toList();

    print("digits: $digits");

    List<int> reversed = digits.reversed.toList();

    print("reversed digits: $reversed");

    int sum = reversed.toList().reduce((value, element) => value + element);

    if ((sum % 10 == 0) && (reversed.length <= 1)) {
      print("ERROR: single zero");

      return false;
    }

    for (var i = 1; i < reversed.length; i += 2) {
      reversed[i] *= 2;

      if (reversed[i] > 9) {
        reversed[i] -= 9;
      }
    }

    print("processed reversed digits: $reversed");

    sum = reversed.toList().reduce((value, element) => value + element);

    print("sum: $sum");

    return sum % 10 == 0;
  }
}
