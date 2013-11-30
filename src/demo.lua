-- demo.lua
-- Copyright (c) 2012-2013 James Deery
-- Released under the MIT license <http://opensource.org/licenses/MIT>.
-- See COPYING for details.

local host = require 'host'

local function DemoApp()
	local self = {
		root_text = Property('<-- Drag me!'),
		model_scale = Property(1),
		model_pan = Property(0, 0)
	}

	local model = ModelContextViewModel()

	function self.model() return model end

	function self.set_text_1()
		self:root_text('Quick brown fox')
	end
	function self.set_text_2()
		self:root_text('«€1.234.567,89, s’il vous plaît»')
	end

	function self.load()
		show_load_file(function(path)
			model:load(path)
		end)
	end
	function self.save()
		show_save_file(function(path)
			model:save(path)
		end)
	end
	function self.add_path()
		model:add_path():select()
	end
	function self.remove_point()
		local path = model:selected_path()
		if path then
			path:points()[1]:remove()
		end
	end
	function self.remove_path()
		model:remove_path()
	end

	return self
end

local Icons = {
	set_text_1 = Model({
		  3.00,   8.00, 0,
		 -3.00,   8.00, 0,
		 -9.00,   2.00, 0,
		 -3.00,   2.00, 0,
		 -3.00,  -8.00, 0,
		  3.00,  -8.00, 0
	}),
	set_text_2 = Model({
		  7.00,  -9.50, 0,
		  7.00,  -6.17, 0,
		 -1.81,  -6.17, 0,
		  7.00,  -1.37, 0.5,
		  7.00,   8.42, 0.5,
		 -2.90,  10.40, 0.5,
		 -7.00,   5.16, 0,
		 -4.20,   2.35, 0,
		 -0.34,   6.57, 0.5,
		  3.63,   3.40, 0.5,
		  0.19,  -0.38, 0.5,
		 -7.00,  -4.86, 0.5,
		 -7.00,  -9.50, 0
	}),
	load = Model({
		  4.00,  10.00, 0,
		 -4.00,  10.00, 0,
		 -4.00,  -1.00, 0,
		 -9.00,  -1.00, 0,
		 -9.00,  -3.00, 0,
		  0.00, -11.00, 0,
		  9.00,  -3.00, 0,
		  9.00,  -1.00, 0,
		  4.00,  -1.00, 0
	}),
	save = Model({
		  4.00,   1.00, 0,
		  9.00,   1.00, 0,
		  9.00,   3.00, 0,
		  0.00,  11.00, 0,
		 -9.00,   3.00, 0,
		 -9.00,   1.00, 0,
		 -4.00,   1.00, 0,
		 -4.00, -10.00, 0,
		  4.00, -10.00, 0
	}),
	add_path = Model({
		 -3.00,  11.00, 0,
		 -7.00,  11.00, 0,
		 -7.00,   7.00, 0,
		-11.00,   7.00, 0,
		-11.00,   3.00, 0,
		 -7.00,   3.00, 0,
		 -7.00,  -1.00, 0,
		 -3.00,  -1.00, 0,
		 -3.00,   3.00, 0,
		  1.00,   3.00, 0,
		  1.00,   7.00, 0,
		 -3.00,   7.00, 0
		}, {
		-13.09,  -7.31, 0,
		 -7.61, -12.25, 0.5,
		  0.83,  -9.52, 0.5,
		  3.43,  -2.90, 0.5,
		  6.28,   0.38, 0.5,
		 10.61,  -2.26, 0,
		 13.58,   1.22, 0,
		  7.25,   5.14, 0.5,
		  0.57,   0.58, 0.5,
		 -2.04,  -6.54, 0.5,
		 -7.21,  -7.41, 0.5,
		-10.36,  -4.29, 0,
	}),
	remove_point = Model({
		-11.00,   7.00, 0,
		-11.00,   3.00, 0,
		  1.00,   3.00, 0,
		  1.00,   7.00, 0
		}, {
		  9.00,  -9.00, 0,
		  9.00,  -2.00, 0,
		  2.00,  -2.00, 0,
		  2.00,  -9.00, 0
	}),
	remove_path = Model({
		-11.00,   7.00, 0,
		-11.00,   3.00, 0,
		  1.00,   3.00, 0,
		  1.00,   7.00, 0
		}, {
		-13.09,  -7.31, 0,
		 -7.61, -12.25, 0.5,
		  0.83,  -9.52, 0.5,
		  3.43,  -2.90, 0.5,
		  6.28,   0.38, 0.5,
		 10.61,  -2.26, 0,
		 13.58,   1.22, 0,
		  7.25,   5.14, 0.5,
		  0.57,   0.58, 0.5,
		 -2.04,  -6.54, 0.5,
		 -7.21,  -7.41, 0.5,
		-10.36,  -4.29, 0,
	}),
	exit = Model({
		  0.00,   3.00, 0,
		 -8.00,  11.00, 0,
		-11.00,   8.00, 0,
		 -3.00,   0.00, 0,
		-11.00,  -8.00, 0,
		 -8.00, -11.00, 0,
		  0.00,  -3.00, 0,
		  8.00, -11.00, 0,
		 11.00,  -8.00, 0,
		  3.00,   0.00, 0,
		 11.00,   8.00, 0,
		  8.00,  11.00, 0
	})
}

local function DemoUI(root, app)
	root:fill_colour(0.1, 0.2, 0.3, 1.0)
		:grid_colour(0.2, 0.3, 0.4)
		:text_location(70, 10)
		:text_size(20)
		:bind_property('text', app.root_text)

	ModelWidget():add_to(root)
		:layout(40, nil, 10, 40, nil, 60)
		:bind_model(app:model())
		:bind_scale(app.model_scale)
		:bind_pan(app.model_pan)

	SliderWidget():add_to(root)
		:layout(10, nil, nil, 10, nil, 10)
		:range(0.1, 200)
		:scale_type(SliderWidget.LogScale)
		:bind_value(app.model_scale)

	PanningWidget():add_to(root)
		:layout(40, nil, nil, 10, nil, nil)
		:bind_value(app.model_pan)
		:bind_property('scale', app.model_scale)

	ColourWidget():add_to(root)
		:layout(40, nil, nil, nil, nil, 10)
		:bind_value(app:model().current_colour)

	Toolbar():add_to(root)
		:add_button(0.2, 0.5, 0.9, Icons.set_text_1, app.set_text_1)
		:add_button(0.0, 0.8, 0.2, Icons.set_text_2, app.set_text_2)
		:add_button(0.9, 0.6, 0.3, Icons.load, app.load)
		:add_button(0.8, 0.9, 0.1, Icons.save, app.save)
		:add_spacer()
		:add_button(0.2, 0.5, 0.9, Icons.add_path, app.add_path)
		:add_button(0.5, 0.1, 0.6, Icons.remove_point, app.remove_point)
		:add_button(0.8, 0.2, 0.2, Icons.remove_path, app.remove_path)
		:add_spacer()
		:add_button(0.9, 0.3, 0.1, Icons.exit, host.exit)
		:layout(nil, nil, 10, nil, nil, 10)

	return root
end

local app = DemoApp()
DemoUI(Widget.root(), app)
