extends Spatial

onready var cameraspin = $Cameraspin

func _ready():
	cameraspin.play("Spinning")

func _on_PlayGame_pressed():
	$Menu/cameramenubotons.hide()
	var elpepe = load("res://FirstPerson2.tscn")
	get_parent().add_child(elpepe.instance())
	$Menu.hide()
	$MenuMusic.stop()
	
func _on_NegroTimer_timeout():
	$Menu/cameramenubotons/Negro.hide()

func _on_Exit_pressed():
	get_tree().quit()

func _on_Guide_pressed():
	$Menu/cameramenubotons/FondodeMenus.show()
	$Menu/cameramenubotons/Guide/Sysguidetitle.show()
	$Menu/cameramenubotons/Extras/Sysextrastitle.hide()
	$Menu/cameramenubotons/Credits/Syscreditstitle.hide()
	$Menu/cameramenubotons/Options/Sysoptiontitle.hide()
	$Menu/cameramenubotons/Guide/numeroguia.show()
	$Menu/cameramenubotons/Guide/Guidetitles.show()
	$Menu/cameramenubotons/Options/botoncitos.hide()

func _on_Options_pressed():
	$Menu/cameramenubotons/FondodeMenus.show()
	$Menu/cameramenubotons/Options/Sysoptiontitle.show()
	$Menu/cameramenubotons/Extras/Sysextrastitle.hide()
	$Menu/cameramenubotons/Credits/Syscreditstitle.hide()
	$Menu/cameramenubotons/Guide/Sysguidetitle.hide()
	$Menu/cameramenubotons/Guide/numeroguia.hide()
	$Menu/cameramenubotons/Guide/Guidetitles.hide()
	$Menu/cameramenubotons/Options/botoncitos.show()

func _on_Credits_pressed():
	$Menu/cameramenubotons/FondodeMenus.show()
	$Menu/cameramenubotons/Credits/Syscreditstitle.show()
	$Menu/cameramenubotons/Options/Sysoptiontitle.hide()
	$Menu/cameramenubotons/Extras/Sysextrastitle.hide()
	$Menu/cameramenubotons/Guide/Sysguidetitle.hide()
	$Menu/cameramenubotons/Guide/numeroguia.hide()
	$Menu/cameramenubotons/Guide/Guidetitles.hide()
	$Menu/cameramenubotons/Options/botoncitos.hide()

func _on_Extras_pressed():
	$Menu/cameramenubotons/FondodeMenus.show()
	$Menu/cameramenubotons/Extras/Sysextrastitle.show()
	$Menu/cameramenubotons/Credits/Syscreditstitle.hide()
	$Menu/cameramenubotons/Options/Sysoptiontitle.hide()
	$Menu/cameramenubotons/Guide/Sysguidetitle.hide()
	$Menu/cameramenubotons/Guide/numeroguia.hide()
	$Menu/cameramenubotons/Guide/Guidetitles.hide()
	$Menu/cameramenubotons/Options/botoncitos.hide()
