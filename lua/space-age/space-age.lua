local SpaceAge = {}
SpaceAge.__index = SpaceAge

function SpaceAge:new(seconds)
	local orbital_periods = {
		Mercury = 0.2408467,
		Venus = 0.61519726,
		Earth = 1.0,
		Mars = 1.8808158,
		Jupiter = 11.862615,
		Saturn = 29.447498,
		Uranus = 84.016846,
		Neptune = 164.79132,
	}

	local seconds_in_earth_years = 365.25 * 24 * 60 * 60

	return {
		-- one of the tests wants to retreive the seconds
		seconds = seconds,

		-- these have to be anonymous functions
		on_mercury = function()
			return tonumber(("%.2f"):format(seconds / (orbital_periods.Mercury * seconds_in_earth_years)))
		end,

		on_venus = function()
			return tonumber(("%.2f"):format(seconds / (orbital_periods.Venus * seconds_in_earth_years)))
		end,

		on_earth = function()
			return tonumber(("%.2f"):format(seconds / (orbital_periods.Earth * seconds_in_earth_years)))
		end,

		on_mars = function()
			return tonumber(("%.2f"):format(seconds / (orbital_periods.Mars * seconds_in_earth_years)))
		end,

		on_jupiter = function()
			return tonumber(("%.2f"):format(seconds / (orbital_periods.Jupiter * seconds_in_earth_years)))
		end,

		on_saturn = function()
			return tonumber(("%.2f"):format(seconds / (orbital_periods.Saturn * seconds_in_earth_years)))
		end,

		on_uranus = function()
			return tonumber(("%.2f"):format(seconds / (orbital_periods.Uranus * seconds_in_earth_years)))
		end,

		on_neptune = function()
			return tonumber(("%.2f"):format(seconds / (orbital_periods.Neptune * seconds_in_earth_years)))
		end,
	}
end

return SpaceAge
