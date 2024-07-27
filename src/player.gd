extends CharacterBody2D

@onready var hud = get_node("../HUD")

signal dead(body)

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const BASE_DAMAGE = 15
const STAMINA_COST = 40
const STAMINA_RECOVERY = 10 # stamina per second
const HEALTH_RECOVERY = 1   # health per second

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var is_attacking = false
@export var is_dead = false
@export var is_hit = false

var attacks_array = ["attack_1", "attack_2", "attack_3"]
var current_attack_anim

var is_navigating = false

func init():
	is_attacking = false
	is_dead = false
	is_hit = false
	hud.increase_health(100)
	hud.increase_stamina(100)

#func _process(_delta):
#	if is_dead:
#		get_tree().reload_current_scene()

func _physics_process(delta):
	if is_navigating:
		velocity.x = 0
		set_motion_mode(1)
		move_and_slide()
		return

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump and double jump
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif hud.get_stamina() > STAMINA_COST:
			velocity.y = JUMP_VELOCITY
			hud.increase_stamina(-1 * STAMINA_COST)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		if is_hit:
			$AnimatedSprite2D.play("hit")
		elif is_attacking:
			$AnimatedSprite2D.play(current_attack_anim)
		elif is_on_floor():
			if Input.is_action_pressed("crouch"):
				$AnimatedSprite2D.play("crouch")
			else:
				$AnimatedSprite2D.play("walk")
		else:
			$AnimatedSprite2D.play("jump")
			
		if direction < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_hit:
			$AnimatedSprite2D.play("hit")
		elif is_attacking:
			$AnimatedSprite2D.play(current_attack_anim)
		elif is_on_floor():
			if Input.is_action_pressed("crouch"):
				$AnimatedSprite2D.play("crouch")
			else:
				$AnimatedSprite2D.play("idle")
		else:
			$AnimatedSprite2D.play("jump")
	
	# Handle attack.
	if not is_attacking and Input.is_action_just_pressed("attack"):
		is_attacking = true
		current_attack_anim = attacks_array.pick_random()
		$AnimatedSprite2D.play(attacks_array.pick_random())
			
	move_and_slide()

func _on_animated_sprite_2d_animation_looped():
	if $AnimatedSprite2D.animation.begins_with("attack"):
		is_attacking = false
	if $AnimatedSprite2D.animation.begins_with("hit"):
		is_hit = false

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
		
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()
		
	if event.is_action_pressed("crouch"):
		var shape = CapsuleShape2D.new()
		shape.height = 20
		$CollisionShape2D.set_shape(shape)
	
	if event.is_action_released("crouch"):
		var shape = CapsuleShape2D.new()
		shape.height = 30
		$CollisionShape2D.set_shape(shape)

func _on_visible_on_screen_notifier_2d_screen_exited():
	print("exited")
	die()

func _on_enemy_left_entered(enemy):
	if is_attacking and not $AnimatedSprite2D.flip_h:
		enemy.die()
	else:
		hit()

func _on_enemy_right_entered(enemy):
	if is_attacking and $AnimatedSprite2D.flip_h:
		enemy.die()
	else:
		hit()
	
func _on_enemy_top_entered(enemy):
	hit()

func _on_bullet_entered(bullet):
	hit()
	
func hit():
	# Wait for the animation to finish before being hit again
	if is_hit: 
		return
		
	is_hit = true
	$AnimatedSprite2D.play("hit")
	
	var damage =  -1 * round(BASE_DAMAGE * (randf() + 1))
	hud.increase_health(damage)
	
	$Damage_indicator.visible = true
	$Damage_indicator.text = str(damage * -1)
	await get_tree().create_timer(1.0).timeout
	$Damage_indicator.visible = false
	
	if hud.get_health() <= 0:
		die()
	
func die():
	print("died")
	is_dead = true
	dead.emit(self)

func _on_timer_timeout():
	hud.increase_stamina(STAMINA_RECOVERY)
	hud.increase_health(HEALTH_RECOVERY)


func _on_boat_boarded(body):
	is_navigating = true
