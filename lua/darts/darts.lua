local Darts = {}

function Darts.score(x, y)
    local distance = math.sqrt(x ^ 2 + y ^ 2)

    if distance <= 1.0 then
        return 10
    end

    if distance <= 5.0 then
        return 5
    end

    if distance <= 10.0 then
        return 1
    end

    return 0
end

return Darts
