extends Control
var pickedUp = false
var stackable = true
var stacked = false
var locked = false
var topcoin = null
@onready var animation_player = $AnimationPlayer

func _physics_process(delta):
	if !pickedUp and stackable and topcoin != null:
		stacked = true
	if pickedUp:
		global_position = get_global_mouse_position()
	if stacked and topcoin != null:
		global_position = topcoin.global_position
		global_position[1] -=12

func _on_coin_button_down():
	if not stacked:
		z_index = 1
	animation_player.play("pick up")
	pickedUp = true

func _on_coin_button_up():
	z_index = 0
	animation_player.play("drop")
	pickedUp = false
	stackable = true
	await get_tree().create_timer(.1).timeout
	stackable = false

