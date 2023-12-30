return function(numbers)
    local function get_multiples(factor, limit)
        local multiples = {}

        for multiple = 1, limit - 1 do
            if multiple % factor == 0 then
                table.insert(multiples, multiple)
            end
        end

        return multiples
    end

    local function to(base_value)
        local sum = 0

        if base_value == 0 then
            return sum
        end

        local hash = {}
        local unique = {}
        local multiples = {}

        for _, item in pairs(numbers) do
            for _, number in ipairs(get_multiples(item, base_value)) do
                table.insert(multiples, number)
            end
        end

        for _, value in ipairs(multiples) do
            hash[value] = true
        end

        for key, _ in pairs(hash) do
            table.insert(unique, key)
        end

        for _, value in ipairs(unique) do
            sum = sum + value
        end

        return sum
    end

    return {
        to = to,
    }
end
