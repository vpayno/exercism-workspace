local TwoFer = {}

function TwoFer.two_fer(name)
    name = name or "you"

    local response = "One for " .. name .. ", one for me."

    return response
end

return TwoFer
