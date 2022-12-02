extends Node

var transla = false

func _on_TranslateAreas_area_entered(area):
	if area.is_in_group("PlayerArea"):
		$Translate4.show()

func _on_TranslateAreas_area_exited(area):
	if area.is_in_group("PlayerArea"):
		$Translate4.hide()
		$Translate3.hide()
