extends Control

func _on_Back_pressed():
	get_tree().change_scene("res://menuprincipal.tscn")

func _on_Extras_pressed():
	get_tree().change_scene("res://extras.tscn")

func _on_Credits_pressed():
	get_tree().change_scene("res://credits.tscn")

func _on_Fullscreen_pressed():
	OS.window_fullscreen = !OS.window_fullscreen

var music_bus = AudioServer.get_bus_index("Master")
func _on_mute_pressed():
	AudioServer.set_bus_mute(music_bus, not AudioServer.is_bus_mute(music_bus))

func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Master"),
		linear2db(value)
	)

var mouse_sensitivity = 0.05
func _on_mouseinvert_pressed(event):
	pass

func _on_HSlider2_value_changed(value):
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Music"),
		linear2db(value)
	)
