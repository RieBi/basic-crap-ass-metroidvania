extends CharacterBody2D

#state machine code using "Animation Tree State Machine Setup .." by Chris' Tutorials
@onready var animation_tree : AnimationTree = $AnimationTree

const MAX_SPEED = 400.0
const JUMP_VELOCITY = -700.0
const EXTRA_FALL_GRAVITY = 20
var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")



#gravity and jump (using videos "Pixel Platformer Tutorial [...]"* parts 1+2 by HeartBeast)
func _physics_process(delta):
	velocity.y += 10
	move_and_slide()
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	#jump
	if is_on_floor():
		if Input.is_action_just_pressed("Up"):
			velocity.y = JUMP_VELOCITY

	#fast falling
	elif velocity.y > 0:
		velocity.y += EXTRA_FALL_GRAVITY
	#terminal velocity
	velocity.y = min(velocity.y, 1500)

#walk (using video * part2 by HeartBeast)
	var direction = Input.get_axis("Left", "Right")
	
	if direction:
		velocity.x = move_toward(velocity.x, direction * MAX_SPEED, 10)
	else:
		velocity.x = move_toward(velocity.x, 0, MAX_SPEED)



#animation
	#idk how to convert horizontal flipping of AnimatedSprite2D to that of AnimationTree
	##horizontal flipping
	#if velocity.x < 0:
		#animation.flip_h = true
	#if velocity.x > 0:
		#animation.flip_h = false

	#state machine code using "Animation Tree State Machine Setup .." by Chris' Tutorials
func update_animation_parameters():
	var idle = animation_tree["parameters/conditions/idle"]
	var is_walking = animation_tree["parameters/conditions/is_walking"]
	var is_jumping = animation_tree["parameters/conditions/is_jumping"]
	var is_falling = animation_tree["parameters/conditions/is_falling"]

	if is_on_floor():
		is_jumping = false
		is_falling = false

		if velocity.x == 0:
			idle = true
			is_walking = false
		else:
			idle = false
			is_walking = true


	else:
		is_walking = false
		is_falling = false

		if velocity.y < 0:
			is_jumping = true
			idle = false
		else:
			is_falling = true
			is_jumping = false
