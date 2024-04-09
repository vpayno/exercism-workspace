def is_pling: . % 3 == 0;
def is_plang: . % 5 == 0;
def is_plong: . % 7 == 0;

def not_sound: (is_pling | not) and (is_plang | not ) and (is_plong | not);

.number | if not_sound then (. | tostring)
else (
    (if is_pling then "Pling" else "" end )+
    (if is_plang then "Plang" else "" end )+
    (if is_plong then "Plong" else "" end)
) end
