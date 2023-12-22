local function ability(scores)
	table.sort(scores)

	return scores[2] + scores[3] + scores[4]
end

local function roll_dice()
	local scores = {}

	for i = 1, 4 do
		scores[i] = math.random(1, 6)
	end

	return scores
end

local function modifier(input)
	return math.floor((input - 10) / 2)
end

local Character = {
	new = function(self, name)
		local constitution = ability(roll_dice())

		return {
			name = name,
			strength = ability(roll_dice()),
			dexterity = ability(roll_dice()),
			constitution = constitution,
			intelligence = ability(roll_dice()),
			wisdom = ability(roll_dice()),
			charisma = ability(roll_dice()),
			hitpoints = 10 + modifier(constitution),
		}
	end,
}

return {
	Character = Character,
	ability = ability,
	roll_dice = roll_dice,
	modifier = modifier,
}
