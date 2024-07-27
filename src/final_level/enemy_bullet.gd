extends Area2D

@export var speed = 200

#signal entered(bullet)

func start(pos):
	position = pos
	position.x = position.x - 20 # workaround ... :-)
	position.y = position.y + 20 # workaround ... :-)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x -= speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_body_entered(body):
	if body.name == "Player":
		body.hit()
		#entered.emit(self)
