extends Control
var dragging = false
var rotated = false
@onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if dragging:
		if !rotated:
			animation_player.play("pickUp")
			rotated = true
		global_position = get_global_mouse_position()
	else:
		if rotated:
			animation_player.play("place")
			rotated = false


func _on_texture_button_button_down():
	$candleSprite.z_index = 1
	dragging = true

func _on_texture_button_button_up():
	dragging = false
