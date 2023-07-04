#include "allergies.h"

bool is_allergic_to(allergen_t allergen, uint16_t score) {
    return ((uint16_t)((uint16_t)1 << (uint16_t)allergen) & score) > 0;
}

allergen_list_t get_allergens(uint16_t score) {
    allergen_list_t allergies;
    allergies.count = 0;

    for (allergen_t allergen = ALLERGEN_EGGS; allergen < ALLERGEN_COUNT;
         allergen++) {
        allergies.allergens[allergen] = is_allergic_to(allergen, score);
        if (allergies.allergens[allergen]) {
            allergies.count++;
        }
    }

    return allergies;
}
