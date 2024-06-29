extends Control

signal trumpIsHeart
signal trumpIsDimonod
signal trumpIsClub
signal trumpIsSpade


# Called when the node enters the scene tree for the first time.
func _ready():
	position[1]=-150


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _on_heart_button_pressed():
	trumpIsHeart.emit()


func _on_dimond_button_pressed():
	trumpIsDimonod.emit()
	

func _on_club_button_pressed():
	trumpIsClub.emit()


func _on_spade_button_pressed():
	trumpIsSpade.emit()
