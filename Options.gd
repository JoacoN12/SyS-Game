extends TextureButton

func _on_Musicbar_value_changed(value):
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Music"),
		linear2db(value)
	)

func _on_SFXbar_value_changed(value):
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("SFX"),
		linear2db(value)
	)

func _on_Vsync_pressed():
	OS.vsync_enabled = !OS.vsync_enabled

func _on_Vsync2_pressed():
	OS.window_fullscreen = !OS.window_fullscreen

func _on_Vsync3_pressed():
	OS.window_borderless = !OS.window_borderless
