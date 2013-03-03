-- demo.lua
-- Copyright (c) 2012-2013 James Deery
-- Released under the MIT license <http://opensource.org/licenses/MIT>.
-- See COPYING for details.

local function DemoApp()
	local self = {
		root_text = Observable('<-- Drag me!'),
		model = ModelContextViewModel(),
		model_scale = Observable(1),
		model_pan = Observable(0, 0)
	}

	function self.set_text_1()
		self.root_text('Quick brown fox')
	end
	function self.set_text_2()
		self.root_text('«€1.234.567,89, s’il vous plaît»')
	end

	function self.load()
		show_load_file(function(path)
			self.model:load(path)
		end)
	end
	function self.save()
		show_save_file(function(path)
			self.model:save(path)
		end)
	end
	function self.add_path()
		self.model:add_path():select()
	end
	function self.remove_point()
		self.model:remove_point()
	end
	function self.remove_path()
		self.model:remove_path()
	end

	return self
end

local function build_ui(app)
	local root = Widget.root()
		:fill_colour(0.1, 0.2, 0.3, 1.0)
		:grid_colour(0.2, 0.3, 0.4)
		:text_location(70, 10)
		:text_size(20)
		:bind_property('text', app.root_text)

	ModelWidget():add_to(root)
		:layout(40, nil, 10, 40, nil, 60)
		:bind_model(app.model)
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
		:bind_value(app.model.current_colour)

	Toolbar():add_to(root)
		:add_button(0.2, 0.5, 0.9, app.set_text_1)
		:add_button(0.0, 0.8, 0.2, app.set_text_2)
		:add_button(0.9, 0.6, 0.3, app.load)
		:add_button(0.8, 0.9, 0.1, app.save)
		:add_spacer()
		:add_button(0.2, 0.5, 0.9, app.add_path)
		:add_button(0.5, 0.1, 0.6, app.remove_point)
		:add_button(0.8, 0.2, 0.2, app.remove_path)
		:add_spacer()
		:add_button(0.9, 0.3, 0.1, commands.exit)
		:layout(nil, nil, 10, nil, nil, 10)
end

do
	local app = DemoApp()
	build_ui(app)
end
