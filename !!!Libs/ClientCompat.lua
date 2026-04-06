-- Shared client/Lua compatibility shims for Turtle/1.12 clients.

if not string.match then
	function string.match(text, pattern, init)
		local results = { string.find(text, pattern, init) }
		local count = table.getn(results)

		if count == 0 then
			return nil
		end

		if count <= 2 then
			return string.sub(text, results[1], results[2])
		end

		return unpack(results, 3, count)
	end
end
