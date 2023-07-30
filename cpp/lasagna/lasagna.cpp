enum {
    OVEN_TIME = 40,
    TIME_PER_LAYER = 2,
};

using minutes_t = int;

// ovenTime returns the amount in minutes that the lasagna should stay in the
// oven.
minutes_t ovenTime() { return OVEN_TIME; }

/* remainingOvenTime returns the remaining
   minutes based on the actual minutes already in the oven.
*/
minutes_t remainingOvenTime(minutes_t actualMinutesInOven) {
    // Calculate and return the remaining in the oven based on the time the
    // lasagna has already been there.
    return ovenTime() - actualMinutesInOven;
}

/* preparationTime returns an estimate of the preparation time based on the
   number of layers and the necessary time per layer.
*/
minutes_t preparationTime(minutes_t numberOfLayers) {
    // Calculate and return the preparation time with the `numberOfLayers`.
    return TIME_PER_LAYER * numberOfLayers;
}

// elapsedTime calculates the total time spent to create and bake the lasagna so
// far.
minutes_t elapsedTime(minutes_t numberOfLayers, minutes_t actualMinutesInOven) {
    // Calculate and return the total time so far.
    return preparationTime(numberOfLayers) + actualMinutesInOven;
}
