extends Label

onready var elpepe = $"../../../.."

func _process(_delta):
	self.text = str(elpepe.player_health)
