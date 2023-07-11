#include "luhn.h"

bool luhn(const char *str) {
    bool result = false;

    // fail if the string doesn't only have digits and spaces in it
    if (!is_valid_input(str)) {
        return result;
    }

    // extract the numbers from the string in reverse order
    numbers_list_t numbers = get_numbers(str);

    // double numbers with index 1, 3, 5, ...
    for (int i = 1; i < numbers.size; i += 2) {
        numbers.list[i] *= 2;

        // if the doubled number is > 9, subtract 9 from it
        if (numbers.list[i] > 9) {
            numbers.list[i] -= 9;
        }
    }

    // if the sum is divisible by 10, it's valid
    if (sum(numbers) % 10 == 0) {
        result = true;
    }

    return result;
}

int sum(numbers_list_t numbers) {
    int total = 0;

    if (numbers.size == 0) {
        return total;
    }

    for (int i = 0; i < numbers.size; i++) {
        total += numbers.list[i];
    }

    return total;
}

bool is_valid_input(const char *str) {
    // strings of length 1 or less are not valid
    if (strlen(str) <= 1) {
        return false;
    }

    int digit_count = 0;

    for (size_t i = 0; i < strlen(str); i++) {
        if (isdigit(str[i])) {
            digit_count += 1;
        }

        // only digits and spaces are allowed
        if (!isdigit(str[i]) && !isspace(str[i])) {
            return false;
        }
    }

    // string needs to have at least 2 digits
    // single digit can't be evenly divisible by 10
    return digit_count >= 2;
}

int count_numbers(const char *str) {
    int count = 0;

    for (size_t i = 0; i < strlen(str) - 1; i++) {
        if (isdigit(str[i])) {
            count += 1;
        }
    }

    return count;
}

numbers_list_t get_numbers(const char *str) {
    numbers_list_t numbers;
    numbers.size = 0;

    // counting digits first so we can store them backwards
    int count = count_numbers(str);

    for (size_t i = 0; i < strlen(str) - 0; i++) {
        if (isdigit(str[i])) {
            // convert to digit and add to array backwards
            numbers.list[count - numbers.size++] = str[i] - '0';
        }
    }

    return numbers;
}
