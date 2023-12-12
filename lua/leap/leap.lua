local leap_year = function(year)
    if year % 400 == 0 then
        return true
    end

    if year % 100 == 0 then
        return false
    end

    if year % 4 == 0 then
        return true
    end

    return false
end

return leap_year
