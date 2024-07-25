extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

enum {IDLE, LEFT, RIGHT, JUMP}
var state = IDLE
@export var stateDuration = 1.0

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

func _process(delta):
	match state:
		IDLE:
			$AnimatedSprite2D.animation = "idle"
		_:
			$AnimatedSprite2D.animation = "run"

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	match state:
		IDLE:
			velocity.x = 0
		RIGHT:
			velocity.x = SPEED
		LEFT:
			velocity.x = -SPEED

	move_and_slide()
