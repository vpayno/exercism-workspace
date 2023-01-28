/// https://exercism.org/tracks/dart/exercises/two-fer

// reverse(String) returns the string in reverse order
String reverse(String text) {
  var chars = text.split('');
  var reversed = chars.reversed;
  var output = reversed.join();

  return output;
}
