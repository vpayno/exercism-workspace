/// Given a year, report if it is a leap year.
/// https://exercism.org/tracks/dart/exercises/leap
class Leap {
  // Check if year is a leap year.
  // on every year that is evenly divisible by 4
  //   except every year that is evenly divisible by 100
  //     unless the year is also evenly divisible by 400
  bool leapYear(int year) {
    if (year % 400 == 0) {
      return true;
    }

    if (year % 100 == 0) {
      return false;
    }

    if (year % 4 == 0) {
      return true;
    }

    return false;
  }
}
