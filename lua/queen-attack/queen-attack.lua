return function(pos)
	assert(pos.row >= 0 and pos.row < 8, "Invalid board row")
	assert(pos.column >= 0 and pos.column < 8, "Invalid board column")

	local function _slope(p1, p2)
		return (p2.column - p1.column) / (p2.row - p1.row)
	end

	return {
		row = pos.row,
		column = pos.column,
		can_attack = function(other_pos)
			local slope = math.abs(_slope(pos, other_pos))

			-- same row or diagonal or same column
			return slope == 0.0 or slope == 1.0 or slope == math.huge
		end,
	}
end
