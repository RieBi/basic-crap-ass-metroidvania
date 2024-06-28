extends Marker2D
class_name ComponentLevelCamera

@export var level_area: Area2D

func _ready() -> void:
	level_area.body_entered.connect(
		func(body):
			if body.is_in_group("player"):
				set_camera_to_here()
	)

func set_camera_to_here() -> void:
	var main_camera: Camera2D = get_tree().get_first_node_in_group("main_camera")
	main_camera.global_position = global_position
