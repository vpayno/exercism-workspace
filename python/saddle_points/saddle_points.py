"""Saddle Points Python Exercism"""

from typing import Dict, List, Set


def rotate_matrix(matrix: List[List[int]]) -> List[List[int]]:
    rotated_matrix: List[List[int]] = []

    row: List[int] = []
    col: List[int] = []

    for i in range(len(row)):
        for row in matrix:
            col.append(row[i])

        rotated_matrix.append(col)

    return rotated_matrix


def saddle_points(matrix: List[List[int]]) -> List[Dict[str, int]]:
    """Finds the potential trees where you could build your tree house.

    param: matrix: List[List[int]] - matrix of tree hights
    returns: List[Dict[str, int]] -
    """
    result: List[Dict[str, int]] = []

    # fast return: empty matrix
    if not matrix:
        return result

    # fast return: if the rows aren't the same length, it's irregular
    lengths: Set[int] = {len(row) for row in matrix}
    if len(lengths) > 1:
        raise ValueError("irregular matrix")

    max_rows: List[int] = list(map(max, matrix))
    min_columns: List[int] = list(map(min, zip(*matrix)))

    result = [{"row": r + 1, "column": c + 1} for r, row_max in enumerate(max_rows) for c, col_min in enumerate(min_columns) if row_max == col_min]

    return result
