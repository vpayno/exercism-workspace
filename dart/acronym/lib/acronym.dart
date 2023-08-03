// Convert a phrase to its acronym.
// https://exercism.org/tracks/dart/exercises/acronym

import "dart:math";

class Acronym {
  String abbreviate(String input_text) => input_text
      .toUpperCase()
      .replaceAll(RegExp(r"[^- A-Z]"), "")
      .split(RegExp(r"[- ]"))
      .map((word) => word.substring(0, min(1, word.length)))
      .join();
}
