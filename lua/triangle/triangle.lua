local triangle = {}

local function is_triangle(a, b, c)
    if a == nil or b == nil or c == nil then
        error("Input Error")
    end

    if a <= 0 or b <= 0 or c <= 0 then
        error("Input Error")
    end

    if a + b < c or a + c < b or b + c < a then
        error("Input Error")
    end

    return true
end

local function is_equilateral(a, b, c)
    return is_triangle(a, b, c) and (a == b and a == c)
end

local function is_isosceles(a, b, c)
    return is_triangle(a, b, c) and (a == b or b == c or a == c)
end

local function is_scalene(a, b, c)
    return is_triangle(a, b, c) and (a ~= b and a ~= c and b ~= c)
end

function triangle.kind(a, b, c)
    if is_equilateral(a, b, c) then
        return "equilateral"
    end

    if is_isosceles(a, b, c) then
        return "isosceles"
    end

    if is_scalene(a, b, c) then
        return "scalene"
    end

    return "error"
end

return triangle
