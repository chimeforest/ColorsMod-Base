-- i would have been much happier using the _radiant.call function
-- but this will do for now

local colors_base= class()

function colors_base:init()
	colors_base.proxy_replacement_handler = {}
	colors_base.proxy_replacement_handler.handlers = {};
	
	function colors_base.proxy_replacement_handler:call(args)
    	local position=args.location-radiant.entities.get_world_grid_location(args.structure)
    	args.position = position

		for key,value in pairs(colors_base.proxy_replacement_handler.handlers) do
    		if value:call(args) then
				return
			end
		end

		radiant.entities.add_child(args.structure,args.entity)
    	args.entity:add_component('mob'):set_location_grid_aligned(position):turn_to(args.rotation)
    	if args.ignore_gravity then
	        entity:get_component('mob'):set_ignore_gravity(true)
	    end
	end

	colors_base.proxy_replacement_handler.handlers.table_proxy_replacement_handler = require 'proxy_replacement_handlers.table_proxy_replacement_handler'
end

colors_base:init();

return colors_base;