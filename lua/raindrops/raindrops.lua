return function(n)
	local sounds = string.format("%s%s%s", n % 3 == 0 and "Pling" or "", n % 5 == 0 and "Plang" or "", n % 7 == 0 and "Plong" or "")

	return sounds == "" and tostring(n) or sounds
end
