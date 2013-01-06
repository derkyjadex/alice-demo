-- demo.lua
-- Copyright (c) 2012 James Deery
-- Released under the MIT license <http://opensource.org/licenses/MIT>.
-- See COPYING for details.

do
	Widget.root():fill_colour(0.1, 0.2, 0.3, 1.0)
	Widget.root():grid_size(20, 20)
	Widget.root():grid_colour(0.2, 0.3, 0.4)
	Widget.root():text_location(40, 10)
	Widget.root():text('Hello World')

	local toolbar = Toolbar()
	Widget.root():add_child(toolbar)

	toolbar:add_button(0.2, 0.5, 0.9)
		:bind_down(function()
			Widget.root():text('Quick brown fox')
			Widget.root():invalidate()
		end)

	toolbar:add_button(0.0, 0.8, 0.2)
		:bind_down(function()
			Widget.root():text('«€1.234.567,89, s’il vous plaît»')
			Widget.root():invalidate()
		end)

	toolbar:add_button(0.9, 0.6, 0.3)
		:bind_down(function()
			local shield, file_widget

			shield = Widget()
			shield:fill_colour(0.2, 0.2, 0.2, 0.5)

			file_widget = FileWidget(function(path)
				shield:remove()
				file_widget:remove()

				if path then
					Widget.root():text(path)
					Widget.root():invalidate()
				end
			end)

			Widget.root():add_child(shield)
			shield:layout(0, nil, 0, 0, nil, 0)

			Widget.root():add_child(file_widget)
			file_widget:layout(40, nil, 40, 40, nil, 40)
		end)

	toolbar:add_spacer()

	local slider_widget = SliderWidget(function(x)
		Widget.root():text_size(12 + x * 100)
	end)
	Widget.root():add_child(slider_widget)
	slider_widget:layout(10, nil, nil, 10, nil, 10)

	local text_box = TextBox()
	Widget.root():add_child(text_box)
	text_box:layout(40, nil, 10, 40, nil, nil)
	text_box:grab_keyboard()

	local model_widget = ModelWidget()
	Widget.root():add_child(model_widget)
	model_widget:layout(40, nil, 10, 80, nil, 60)

	local colour_widget = ColourWidget(function(r, g, b)
		model_widget:set_path_colour(r, g, b)
	end)
	Widget.root():add_child(colour_widget)
	colour_widget:layout(40, nil, nil, nil, nil, 10)

	toolbar:add_spacer()

	toolbar:add_button(0.2, 0.5, 0.9)
		:bind_down(function() model_widget:add_path() end)
	toolbar:add_button(0.5, 0.1, 0.6)
		:bind_down(function() model_widget:remove_point() end)
	toolbar:add_button(0.8, 0.2, 0.2)
		:bind_down(function() model_widget:remove_path() end)

	toolbar:add_spacer()

	do
		local button = toolbar:add_button(0.9, 0.3, 0.1)
		button:bind_up(commands.exit)

		local cross = Model()
		cross:add_path(1, -0.15, 0.15, 0.15, -0.15)
		cross:add_path(1, -0.15, -0.15, 0.15, 0.15)
		button:model(cross)
		button:model_location(15, 15)
		button:model_scale(80)
	end

	toolbar:layout(nil, nil, 10, nil, nil, 10)

	Widget.root():bind_down(function()
		Widget.root():grab_keyboard()
	end)
end
