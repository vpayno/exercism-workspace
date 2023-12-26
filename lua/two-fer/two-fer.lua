local TwoFer = {}

function TwoFer.two_fer(name)
    if #name == 0 then
        name = "You"
    end

    return "One for " .. name .. ", one for me."
end

return TwoFer
