// This stub file contains items that aren't used yet; feel free to remove this module attribute
// to enable stricter warnings.
#![allow(unused)]

pub fn expected_minutes_in_oven() -> i32 {
    // Lasagnas always take 40 minutes regardless of the number of layers?
    let minutes: i32 = 40;

    // clippy will complain if we make the return explicit so just use
    // a variable without a traling semicolon.
    minutes
}

pub fn remaining_minutes_in_oven(actual_minutes_in_oven: i32) -> i32 {
    // Remaining time in the oven.
    let remaining_time: i32 = expected_minutes_in_oven() - actual_minutes_in_oven;

    // clippy will complain if we make the return explicit so just use
    // a variable without a traling semicolon.
    remaining_time
}

pub fn preparation_time_in_minutes(number_of_layers: i32) -> i32 {
    let minutes_per_layer: i32 = 2;

    // Preparation time is dependent on the number of layers.
    let preparation_time: i32 = number_of_layers * minutes_per_layer;

    // clippy will complain if we make the return explicit so just use
    // a variable without a traling semicolon.
    preparation_time
}

pub fn elapsed_time_in_minutes(number_of_layers: i32, actual_minutes_in_oven: i32) -> i32 {
    // Time spent preparing and cooking in the oven.
    let mut time_elapsed: i32 = 0;
    time_elapsed += preparation_time_in_minutes(number_of_layers);
    time_elapsed += actual_minutes_in_oven;

    // clippy will complain if we make the return explicit so just use
    // a variable without a traling semicolon.
    time_elapsed
}
