local function flatten(input)
    local result = {}

    for _, outer_value in ipairs(input) do
        if type(outer_value) == "table" then
            local inner_list = flatten(outer_value)

            for _, inner_value in ipairs(inner_list) do
                table.insert(result, inner_value)
            end
        else
            table.insert(result, outer_value)
        end
    end

    return result
end

return flatten
