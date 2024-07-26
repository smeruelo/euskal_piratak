extends Area2D

@export var speed = 200


func start(pos):
	position = pos
	position.x = position.x - 20 # workaround ... :-)
	position.y = position.y + 20 # workaround ... :-)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x -= speed * delta


func _on_visible_on_screen_notifier_2d_screen_entered(area):
	if area.name == "player":
		print("Player hit")
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
