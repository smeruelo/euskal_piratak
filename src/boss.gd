extends Node2D

const DIFFICULTY = 5 # Less is harder, higher is easier

var bullet_scene = preload("res://scenes/final_level/enemy_bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("../HUD/boss_bar").visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func shoot(shooter):
	var b = bullet_scene.instantiate()
	get_tree().root.add_child(b)
	b.start(shooter.global_position)
	
func _on_timer_attack_head_timeout():
	get_node("head_level/AnimatedSprite2D_head").play("attack")
	$Timer_attack_head.start(randi_range(1,DIFFICULTY))
	await get_tree().create_timer(0.7).timeout
	shoot(get_node("head_level/CollisionShape2D"))


func _on_timer_attack_mid_timeout():
	get_node("mid_level/AnimatedSprite2D_mid").play("attack")
	$Timer_attack_mid.start(randi_range(1,DIFFICULTY))
	await get_tree().create_timer(0.7).timeout
	shoot(get_node("mid_level/CollisionShape2D"))


func _on_timer_attack_ground_timeout():
	get_node("ground_level/AnimatedSprite2D_ground").play("attack")
	$Timer_attack_ground.start(randi_range(1,DIFFICULTY))
	await get_tree().create_timer(0.7).timeout
	shoot(get_node("ground_level/CollisionShape2D"))


func _on_animated_sprite_2d_head_animation_looped():
	get_node("head_level/AnimatedSprite2D_head").play("idle")


func _on_animated_sprite_2d_mid_animation_looped():
	get_node("mid_level/AnimatedSprite2D_mid").play("idle")


func _on_animated_sprite_2d_ground_animation_looped():
	get_node("ground_level/AnimatedSprite2D_ground").play("idle")


