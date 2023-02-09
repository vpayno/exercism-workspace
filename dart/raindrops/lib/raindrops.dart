// Convert a number into a string that contains raindrop sounds corresponding to certain potential factors.
// https://exercism.org/tracks/dart/exercises/raindrops

class Raindrops {
  // convert(int) returns a string representation of the number
  String convert(int number) {
    var sounds = new StringBuffer();

    if (number % 3 == 0) {
      sounds.write("Pling");
    }

    if (number % 5 == 0) {
      sounds.write("Plang");
    }

    if (number % 7 == 0) {
      sounds.write("Plong");
    }

    if (sounds.length == 0) {
      sounds.write(number.toString());
    }

    return sounds.toString();
  }
}
