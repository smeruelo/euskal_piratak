extends CharacterBody2D

signal boarded(body)

const SPEED = 500
var is_navigating = false


func _physics_process(delta):
	# Do not drown!
	velocity.y = 0
	
	if is_navigating:
		velocity.x = SPEED * delta
	else:
		velocity.x = 0
	
	move_and_slide()

func _on_area_2d_body_entered(_body):
	print(_body)
	boarded.emit(self)
	is_navigating = true
