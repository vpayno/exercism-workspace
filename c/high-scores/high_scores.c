#include "high_scores.h"

int32_t latest(const int32_t *scores, size_t scores_len) {
    if (scores_len == 0) {
        return 0;
    }

    return scores[scores_len - 1];
}

int32_t personal_best(const int32_t *scores, size_t scores_len) {
    if (scores_len == 0) {
        return 0;
    }

    int32_t best = scores[0];
    for (size_t i = 1; i < scores_len; i++) {
        if (best < scores[i]) {
            best = scores[i];
        }
    }

    return best;
}

size_t personal_top_three(const int32_t *scores, size_t scores_len,
                          int32_t *output) {
    if (scores_len == 0) {
        return 0;
    }

    int32_t sorted[scores_len];
    size_t sorted_len = 0;

    memcpy(sorted, scores, sizeof(int) * scores_len);

    qsort(sorted, scores_len, sizeof(scores[0]), comparator);

    if (scores_len >= 3) {
        output[2] = sorted[scores_len - 3];
        sorted_len++;
    }

    if (scores_len >= 2) {
        output[1] = sorted[scores_len - 2];
        sorted_len++;
    }

    if (scores_len >= 1) {
        output[0] = sorted[scores_len - 1];
        sorted_len++;
    }

    return sorted_len;
}

int32_t comparator(const void *value1, const void *value2) {
    return (*(int32_t *)value1 - *(int32_t *)value2);
}
