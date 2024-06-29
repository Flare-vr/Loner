extends TextureButton
@onready var backCard = $"back card"

signal shuffle
var delt = false


func _on_pressed():
	if delt == false:
		shuffle.emit()
		backCard.position[1] +=5
		delt = true


func _on_mouse_entered():
	if delt:
		pass
	else:
		backCard.position[1] -=5


func _on_mouse_exited():
	if delt:
		pass
	else:
		backCard.position[1] +=5


func _on_game_re_shuffle():
	delt = false
