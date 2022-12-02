extends Control

func _on_Play_pressed():
	get_tree().change_scene("res://World.tscn")

func _on_Quit_pressed():
	get_tree().quit()

func _on_Settings_pressed():
	get_tree().change_scene("res://menuopciones.tscn")
