extends TextureButton

func _on_numeroguiabutton_pressed():
	$Guidetitles/Controlssys.show()
	$Guidetitles/Storysys.hide()
	$Guidetitles/Objectivesys.hide()
	$numeroguia/numeroguiabutton/Controlssys1.show()
	$numeroguia/numeroguiabutton2/Controlssys2.hide()
	$numeroguia/numeroguiabutton3/Storysys1.hide()
	$numeroguia/numeroguiabutton4/Objectivesys1.hide()
	$numeroguia/numeroguiabutton5/Objectivesys2.hide()

func _on_numeroguiabutton2_pressed():
	$Guidetitles/Controlssys.show()
	$Guidetitles/Storysys.hide()
	$Guidetitles/Objectivesys.hide()
	$numeroguia/numeroguiabutton/Controlssys1.hide()
	$numeroguia/numeroguiabutton2/Controlssys2.show()
	$numeroguia/numeroguiabutton3/Storysys1.hide()
	$numeroguia/numeroguiabutton4/Objectivesys1.hide()
	$numeroguia/numeroguiabutton5/Objectivesys2.hide()

func _on_numeroguiabutton3_pressed():
	$Guidetitles/Storysys.show()
	$Guidetitles/Controlssys.hide()
	$Guidetitles/Objectivesys.hide()
	$numeroguia/numeroguiabutton/Controlssys1.hide()
	$numeroguia/numeroguiabutton2/Controlssys2.hide()
	$numeroguia/numeroguiabutton3/Storysys1.show()
	$numeroguia/numeroguiabutton4/Objectivesys1.hide()
	$numeroguia/numeroguiabutton5/Objectivesys2.hide()

func _on_numeroguiabutton4_pressed():
	$Guidetitles/Objectivesys.show()
	$Guidetitles/Storysys.hide()
	$Guidetitles/Controlssys.hide()
	$numeroguia/numeroguiabutton/Controlssys1.hide()
	$numeroguia/numeroguiabutton2/Controlssys2.hide()
	$numeroguia/numeroguiabutton3/Storysys1.hide()
	$numeroguia/numeroguiabutton4/Objectivesys1.show()
	$numeroguia/numeroguiabutton5/Objectivesys2.hide()

func _on_numeroguiabutton5_pressed():
	$Guidetitles/Objectivesys.show()
	$Guidetitles/Storysys.hide()
	$Guidetitles/Controlssys.hide()
	$numeroguia/numeroguiabutton/Controlssys1.hide()
	$numeroguia/numeroguiabutton2/Controlssys2.hide()
	$numeroguia/numeroguiabutton3/Storysys1.hide()
	$numeroguia/numeroguiabutton4/Objectivesys1.hide()
	$numeroguia/numeroguiabutton5/Objectivesys2.show()
