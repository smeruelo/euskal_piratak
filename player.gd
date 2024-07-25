extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var is_attacking = false

func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		
		if is_attacking:
			$AnimatedSprite2D.play("attack_1")
		elif is_on_floor():
			$AnimatedSprite2D.play("walk")
		else:
			$AnimatedSprite2D.play("jump")
			
		if direction < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_attacking:
			$AnimatedSprite2D.play("attack_1")
		elif is_on_floor():
			$AnimatedSprite2D.play("idle")
		else:
			$AnimatedSprite2D.play("jump")
	
	# Handle attack.
	if not is_attacking and Input.is_action_just_pressed("attack"):
		is_attacking = true
		$AnimatedSprite2D.play("attack_1")
			
	move_and_slide()

func _on_animated_sprite_2d_animation_looped():

	if $AnimatedSprite2D.animation.begins_with("attack"):
		is_attacking = false

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
		
	if event.is_action_pressed("ui_text_backspace"):
		get_tree().reload_current_scene()

func _on_visible_on_screen_notifier_2d_screen_exited():
	get_tree().reload_current_scene()
