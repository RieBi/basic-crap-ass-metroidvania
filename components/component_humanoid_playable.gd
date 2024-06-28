extends Node
class_name ComponentHumanoidPlayable

@export var player: CharacterBody2D
@export var max_speed = 400
@export var jump_velocity = -700
@export var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	var horizontal_velocity = Input.get_axis("move_left", "move_right")
	
	if horizontal_velocity:
		player.velocity.x = horizontal_velocity * max_speed
	else:
		player.velocity.x = 0
	
	if player.is_on_floor() and Input.is_action_just_pressed("move_jump"):
		player.velocity.y = jump_velocity
	else:
		player.velocity.y += gravity * delta
	
	player.move_and_slide()
