return function(s)
	local r = ""

	for i = 1, #s do
		r = s:sub(i, i) .. r
	end

	return r
end
