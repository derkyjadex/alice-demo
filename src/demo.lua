-- demo.lua
-- Copyright (c) 2012 James Deery
-- Released under the MIT license <http://opensource.org/licenses/MIT>.
-- See COPYING for details.

do
	local root = Widget.root()
		:fill_colour(0.1, 0.2, 0.3, 1.0)
		:grid_size(20, 20)
		:grid_colour(0.2, 0.3, 0.4)
		:text_location(40, 10)
		:text('Hello World')

	local toolbar = Toolbar():add_to(root)

	toolbar:add_button(0.2, 0.5, 0.9)
		:bind_down(function()
			root:text('Quick brown fox')
				:invalidate()
		end)

	toolbar:add_button(0.0, 0.8, 0.2)
		:bind_down(function()
			root:text('«€1.234.567,89, s’il vous plaît»')
				:invalidate()
		end)

	local text_size = observable(24)
	root:bind_property('text_size', text_size)

	SliderWidget():add_to(root)
		:layout(10, nil, nil, 10, nil, 10)
		:range(12, 112)
		:bind_value(text_size)

	local path_colour = observable(0.9, 0.5, 0.2)

	local model_widget = ModelWidget()
		:add_to(root)
		:layout(40, nil, 10, 40, nil, 60)
		:bind_path_colour(path_colour)

	ColourWidget():add_to(root)
		:layout(40, nil, nil, nil, nil, 10)
		:bind_value(path_colour)

	toolbar:add_button(0.9, 0.6, 0.3)
		:bind_down(function()
			show_load_file(function(path)
				model_widget:load(path)
			end)
		end)

	toolbar:add_button(0.8, 0.9, 0.1)
		:bind_down(function()
			show_save_file(function(path)
				model_widget:save(path)
			end)
		end)

	toolbar:add_spacer()

	toolbar:add_button(0.2, 0.5, 0.9)
		:bind_down(function() model_widget:add_path() end)
	toolbar:add_button(0.5, 0.1, 0.6)
		:bind_down(function() model_widget:remove_point() end)
	toolbar:add_button(0.8, 0.2, 0.2)
		:bind_down(function() model_widget:remove_path() end)

	toolbar:add_spacer()

	toolbar:add_button(0.9, 0.3, 0.1)
		:bind_up(commands.exit)
		:model(Model(
			{3, 27, 27, 3},
			{3, 3, 27, 27}))

	toolbar:layout(nil, nil, 10, nil, nil, 10)
end
