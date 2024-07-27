extends Node2D

const DIFFICULTY = 5 # Less is harder, higher is easier
const PLAYER_BASE_DAMAGE = 15
const MAX_BOSS_HEALTH = 100

var bullet_scene = preload("res://scenes/final_level/enemy_bullet.tscn")

var boss_health = MAX_BOSS_HEALTH

#signal head_entered(Boss)
#signal mid_entered(Boss)
#signal ground_entered(Boss)

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
	
func hit():
	var boss_health_bar = get_node("../HUD/health_bar/TextureProgressBar")	
	var damage = round(PLAYER_BASE_DAMAGE * (randf() + 1))
	
	boss_health = boss_health - damage
	print("Boss health: %s (-%s)" % [boss_health, damage])
	boss_health_bar.value = boss_health
	
	if boss_health <= 2 * (MAX_BOSS_HEALTH / 3):
		#get_node("ground_level").visible = false
		get_node("ground_level/CollisionShape2D").disabled = true
		get_node("ground_level/Area_ground/CollisionShape2D").disabled = true
		$Timer_attack_ground.stop()
		
		
	
	
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


func _on_area_head_body_entered(body):
	if body.name == "Player" and body.is_attacking:
		get_node("head_level/AnimatedSprite2D_head").play("hit")
		hit()
		#head_entered.emit(self)


func _on_area_mid_body_entered(body):
	if body.name == "Player" and body.is_attacking:
		get_node("mid_level/AnimatedSprite2D_mid").play("hit")
		hit()
		#mid_entered.emit(self)
		
		
func _on_area_ground_body_entered(body):
	if body.name == "Player" and body.is_attacking:
		get_node("ground_level/AnimatedSprite2D_ground").play("hit")
		hit()
		#ground_entered.emit(self)



