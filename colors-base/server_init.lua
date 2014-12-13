-- i would have been much happier using the _radiant.call function
-- but this will do for now

local server = class()

function server:init()
	_radiant.proxy_replacement_handler = {}
	_radiant.proxy_replacement_handler.handlers = {};
	
	function _radiant.proxy_replacement_handler:call(entity, location)
		for key,value in pairs(_radiant.proxy_replacement_handler.handlers) do
    		if value:call(entity, location) then
				return
			end
		end

		radiant.terrain.place_entity(entity,location,
			{
				force_iconic=false
			})
	end

	_radiant.proxy_replacement_handler.handlers.table_proxy_replacement_handler = require 'proxy_replacement_handlers.table_proxy_replacement_handler'
end

server:init();

return server;