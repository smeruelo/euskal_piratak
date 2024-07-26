extends Node2D

const DIFFICULTY = 3 # Less is harder, higher is easier

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("../HUD/boss_bar").visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_attack_head_timeout():
	get_node("head_level/AnimatedSprite2D_head").play("attack")
	$Timer_attack_head.start(randi_range(1,DIFFICULTY))


func _on_timer_attack_mid_timeout():
	get_node("mid_level/AnimatedSprite2D_mid").play("attack")
	$Timer_attack_mid.start(randi_range(1,DIFFICULTY))


func _on_timer_attack_ground_timeout():
	get_node("ground_level/AnimatedSprite2D_ground").play("attack")
	$Timer_attack_ground.start(randi_range(1,DIFFICULTY))


func _on_animated_sprite_2d_head_animation_looped():
	get_node("head_level/AnimatedSprite2D_head").play("idle")


func _on_animated_sprite_2d_mid_animation_looped():
	get_node("mid_level/AnimatedSprite2D_mid").play("idle")


func _on_animated_sprite_2d_ground_animation_looped():
	get_node("ground_level/AnimatedSprite2D_ground").play("idle")


