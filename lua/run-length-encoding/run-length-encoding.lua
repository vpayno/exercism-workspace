local function encode(plain_text)
    local buffer = ""

    if #plain_text == 0 then
        return buffer
    end

    local count = 0
    local rune_current = ""
    local rune_last = ""

    for rune in plain_text:gmatch(".") do
        rune_current = rune -- so it survives loop termination

        if rune_last == rune_current then
            count = count + 1
        else
            if count <= 1 then
                buffer = buffer .. rune_last
            else
                buffer = buffer .. count .. rune_last
            end

            rune_last = rune_current
            count = 1
        end
    end

    if count <= 1 then
        buffer = buffer .. rune_current
    else
        buffer = buffer .. count .. rune_current
    end

    return buffer
end

local function decode(cipher_text)
    local buffer = {}

    if #cipher_text == 0 then
        return table.concat(buffer)
    end

    local rune
    local count = -1

    for char in cipher_text:gmatch(".") do
        if string.match(char, "[ A-Za-z]") then
            rune = char

            count = math.max(count, 1)

            table.insert(buffer, rune:rep(count))
            count = -1
        else
            if count > -1 then
                count = count * 10
                count = count + tonumber(char) or 1
            else
                count = tonumber(char) or 1
            end
        end
    end

    return table.concat(buffer)
end

return {
    encode = encode,
    decode = decode,
}
