local grains = {}

function grains.square(index)
    local index_min = 1
    local index_max = 64

    if index < index_min or index > index_max then
        return 0
    end

    return 2 ^ (index - 1)
end

function grains.total()
    return 2 ^ 64
end

return grains
