local all_your_base = {}

local function to_base_10(input_base, input_digits)
	local base_ten = 0

	for _, digit in ipairs(input_digits) do
		assert(digit >= 0, "negative digits are not allowed")
		assert(digit < input_base, "digit out of range")

		base_ten = base_ten * input_base
		base_ten = base_ten + digit
	end

	return base_ten
end

local function from_base_10(output_base, number)
	local output_digits = {}

	while number > 0 do
		local tmp = math.floor(number % output_base)

		table.insert(output_digits, 1, tmp)

		number = math.floor(number / output_base)
	end

	if #output_digits == 0 then
		return { 0 }
	else
		return output_digits
	end
end

all_your_base.convert = function(from_digits, from_base)
	assert(from_base > 1, "invalid input base")

	local function to(to_base)
		assert(to_base > 1, "invalid output base")

		return from_base_10(to_base, to_base_10(from_base, from_digits))
	end

	return { to = to }
end

return all_your_base
