extends Area2D

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var hud = get_node("../../../HUD")

func _on_body_entered(body):
	sprite.play("effect")
	hud.increase_stamina(100)
	await sprite.animation_finished
	
func _on_animated_sprite_2d_animation_finished():
	queue_free() 
