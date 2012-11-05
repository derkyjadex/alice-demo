-- demo.lua
-- Copyright (c) 2012 James Deery
-- Released under the MIT license <http://opensource.org/licenses/MIT>.
-- See COPYING for details.

_, _, root_width, root_height = Widget.root:bounds()

Widget.root:fill_colour(0.1, 0.2, 0.3, 1.0)
Widget.root:grid_size(20, 20)
Widget.root:grid_colour(0.2, 0.3, 0.4)

local toolbar = Toolbar()
local hello_widget = toolbar:add_button(0.2, 0.5, 0.9)
local bye_widget = toolbar:add_button(0.0, 0.8, 0.2)
local open_widget = toolbar:add_button(0.9, 0.6, 0.3)
toolbar:add_spacer()
local exit_widget = toolbar:add_button(0.9, 0.3, 0.1)

exit_widget:bind_up(commands.exit)
exit_widget:model_location(15, 15)
exit_widget:model_scale(80)
do
	local cross = Model()
	cross:add_path(1, -0.15, 0.15, 0.15, -0.15)
	cross:add_path(1, -0.15, -0.15, 0.15, 0.15)
	exit_widget:model(cross)
end

Widget.root:add_child(toolbar)
toolbar:layout(nil, nil, 10, nil, nil, 10)

Widget.root:text_location(40, 10)
Widget.root:text('Hello World')

hello_widget:bind_down(function ()
	Widget.root:text('Quick brown fox')
	Widget.root:invalidate()
end)
bye_widget:bind_down(function ()
	Widget.root:text('«€1.234.567,89, s’il vous plaît»')
	Widget.root:invalidate()
end)

local slider_widget = SliderWidget(function(x)
	Widget.root:text_size(12 + x * 100)
end)
Widget.root:add_child(slider_widget)
slider_widget:layout(10, nil, nil, 10, nil, 10)

Widget.root:add_child(ColourWidget(40, root_height - 210, function(r, g, b)
	Widget.root:text_colour(r, g, b)
end))

open_widget:bind_down(function()
	local shield, file_widget

	shield = Widget()
	shield:fill_colour(0.2, 0.2, 0.2, 0.5)

	file_widget = FileWidget(function(path)
		shield:remove()
		shield:free()
		file_widget:remove()
		file_widget:free()

		if path then
			Widget.root:text(path)
			Widget.root:invalidate()
		end
	end)

	Widget.root:add_child(shield)
	shield:layout(0, nil, 0, 0, nil, 0)

	Widget.root:add_child(file_widget)
	file_widget:layout(40, nil, 40, 40, nil, 40)
end)

local text_box = TextBox()
Widget.root:add_child(text_box)
text_box:layout(40, nil, 10, 40, nil, nil)
text_box:grab_keyboard()

Widget.root:bind_down(function()
	Widget.root:grab_keyboard()
end)
