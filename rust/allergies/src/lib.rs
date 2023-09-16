pub struct Allergies {
    score: u32,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Allergen {
    Eggs = 0b0000_0001,
    Peanuts = 0b0000_0010,
    Shellfish = 0b0000_0100,
    Strawberries = 0b0000_1000,
    Tomatoes = 0b0001_0000,
    Chocolate = 0b0010_0000,
    Pollen = 0b0100_0000,
    Cats = 0b1000_0000,
}

impl Allergies {
    pub fn new(score: u32) -> Self {
        Allergies { score }
    }

    pub fn is_allergic_to(&self, allergen: &Allergen) -> bool {
        self.score & *allergen as u32 == *allergen as u32
    }

    pub fn allergies(&self) -> Vec<Allergen> {
        let allergens: [Allergen; 8] = [
            Allergen::Eggs,
            Allergen::Peanuts,
            Allergen::Shellfish,
            Allergen::Strawberries,
            Allergen::Tomatoes,
            Allergen::Chocolate,
            Allergen::Pollen,
            Allergen::Cats,
        ];
        let mut result: Vec<Allergen> = Vec::new();

        for allergen in allergens {
            if self.is_allergic_to(&allergen) {
                result.push(allergen);
            }
        }

        result
    }
}
