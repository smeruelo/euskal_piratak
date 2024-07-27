extends Area2D

@export var speed = 200
var is_destroyed = false
#signal entered(bullet)

func start(pos):
	position = pos
	position.x = position.x - 20 # workaround ... :-)
	position.y = position.y + 20 # workaround ... :-)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not is_destroyed:
		position.x -= speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_body_entered(body):
	if body.name == "Player":
		body.hit()
		$AnimatedSprite2D.play("destroyed")
		is_destroyed = true
		await get_tree().create_timer(0.3).timeout
		queue_free()
		#entered.emit(self)
