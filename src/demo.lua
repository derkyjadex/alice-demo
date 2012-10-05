-- demo.lua
-- Copyright (c) 2012 James Deery
-- Released under the MIT license <http://opensource.org/licenses/MIT>.
-- See COPYING for details.

_, _, root_width, root_height = Widget.root:bounds()

Widget.root:fill_colour(0.1, 0.2, 0.3, 1.0)
Widget.root:grid_size(20, 20)
Widget.root:grid_colour(0.2, 0.3, 0.4)

local toolbar = Toolbar(root_width - 130, root_height - 50)
local hello_widget = toolbar:add_button(0.2, 0.5, 0.9)
local bye_widget = toolbar:add_button(0.0, 0.8, 0.2)
toolbar:add_spacer()
local exit_widget = toolbar:add_button(0.9, 0.3, 0.1)

exit_widget:bind_up(commands.exit)

local cross = Model()
cross:add_path(1, -0.15, 0.15, 0.15, -0.15)
cross:add_path(1, -0.15, -0.15, 0.15, 0.15)
exit_widget:model_location(15, 15)
exit_widget:model_scale(80)
exit_widget:model(cross)
cross:free()

Widget.root:add_child(toolbar)

local text_widget = Widget()
text_widget:location(40, 10)
text_widget:text('Hello World')
Widget.root:add_child(text_widget)

hello_widget:bind_down(function ()
	text_widget:text('Quick brown fox')
end)
bye_widget:bind_down(function ()
	text_widget:text('$1.234.567,89')
end)

Widget.root:add_child(SliderWidget(10, 10, root_height - 40, function(x)
	text_widget:text_size(12 + x * 100)
end))

Widget.root:add_child(ColourWidget(40, root_height - 210, function(r, g, b)
	text_widget:text_colour(r, g, b)
end))
