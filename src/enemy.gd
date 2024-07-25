extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

enum {IDLE, LEFT, RIGHT, DEAD}
var state = IDLE
@export var stateDuration = 1.0

signal top_entered(enemy)
signal left_entered(enemy)
signal right_entered(enemy)

func _ready():
	$AnimatedSprite2D.play()
	$stateTimer.timeout.connect(_on_state_timer_timeout)
	$stateTimer.start(stateDuration)
	
func _on_state_timer_timeout():
	match state:
		IDLE:
			state = RIGHT
		RIGHT:
			state = LEFT
		LEFT:
			state = IDLE

func _process(_delta):
	match state:
		IDLE:
			$AnimatedSprite2D.animation = "idle"
		LEFT, RIGHT:
			$AnimatedSprite2D.animation = "run"

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	match state:
		IDLE, DEAD:
			velocity.x = 0
		RIGHT:
			velocity.x = SPEED
		LEFT:
			velocity.x = -SPEED

	move_and_slide()


func _on_area_top_body_entered(body):
	print("area top")
	top_entered.emit(self)

func _on_area_left_body_entered(body):
	print("area left")
	left_entered.emit(self)

func _on_area_right_body_entered(body):
	print("area right")
	right_entered.emit(self)

func die():
	print("enemy died")
	$AreaTop.set_collision_mask_value(2, false)
	$AreaLeft.set_collision_mask_value(2, false)
	$AreaRight.set_collision_mask_value(2, false)
	state = DEAD
	$stateTimer.stop()
	$AnimatedSprite2D.animation = "hit"
	var timer = get_tree().create_timer(2.0)
	await timer.timeout
	queue_free()
