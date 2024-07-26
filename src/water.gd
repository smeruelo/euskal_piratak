extends Area2D

@export var _splash : PackedScene

func _spawn_splash(x : float):
	var splash = _splash.instantiate()
	add_child(splash)
	splash.global_position.x = x
	
	
func _on_body_entered(body : Node2D):
	_spawn_splash(body.position.x)
	#body.die()
