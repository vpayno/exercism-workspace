#include "rna_transcription.h"

char *to_rna(const char *dna) {
    size_t dna_length = strlen(dna);
    char *rna = calloc(dna_length + 1, sizeof(char));

    if (dna_length == 0) {
        return rna;
    }

    for (size_t i = 0; i < dna_length; i++) {
        switch (toupper(dna[i])) {
        case 'G':
            rna[i] = 'C';
            break;
        case 'C':
            rna[i] = 'G';
            break;
        case 'T':
            rna[i] = 'A';
            break;
        case 'A':
            rna[i] = 'U';
            break;
        }

        rna[dna_length] = '\0';
    }

    return rna;
}
