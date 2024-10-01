class_name PlatformPlayer extends AbstractPlayer
const SPEED = 300.0
const JUMP_VELOCITY = -200.0
const MAX_JUMP_HEIGHT = -270.0
const AFTER_HIT_INVINCIBILITY = 1

@export var bullet_scene : PackedScene

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var mouse_position : Vector2
var holding_jump = false
var jump_impede = -20
var is_attacking = false
var can_attack = true
var is_hit = false
var is_invincible = false

@onready var animated_sprite : AnimatedSprite2D = get_node("AnimatedSprite")
@onready var melee_attack_hit_box : RayCast2D = get_node("MeleeAttackHitBox")
@onready var attack_cooldown : Timer = get_node("AttackCooldown")
@onready var invincibility_cooldown : Timer = get_node("InvincibilityCooldown")

func _ready():
	pass;
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# Handle jump. https://www.reddit.com/r/godot/comments/18w1k7r/hold_button_to_control_jump_height/	
	if (Input.is_action_just_pressed("player_jump") and is_on_floor()):
		holding_jump = true;
		velocity.y += JUMP_VELOCITY
	
	if Input.is_action_just_released("player_jump") || velocity.y < MAX_JUMP_HEIGHT:
		holding_jump = false
  
	if holding_jump and velocity.y <= jump_impede:
		velocity.y += jump_impede	

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("player_left", "player_right")
	if direction:
		#walk_sfk.play()
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if direction < 0:
		animated_sprite.set_flip_h(true)
		melee_attack_hit_box.scale.x = -1
	elif direction > 0: 
		animated_sprite.set_flip_h(false)
		melee_attack_hit_box.scale.x = 1
		
	if (!is_attacking && !is_hit):
		if !is_on_floor() :
			if velocity.y < 0:
				animated_sprite.play("jump")
			else:
				animated_sprite.play("fall")
		else :
			if direction != 0:
				animated_sprite.play("run")
			else:
				animated_sprite.play("idle")
	elif is_attacking :
		animated_sprite.play("kick")
	
	move_and_slide()

func _process(delta):
	queue_redraw()
	pass
	
#Took too much time, so I just copied from here: https://www.youtube.com/watch?v=gr5xkwYNYIU&ab_channel=DevDrache
func _input(event):	
	if Input.is_action_pressed("melee_attack"):
		is_attacking = true;
		attack_cooldown.start()
		if melee_attack_hit_box.is_colliding():
			var collider = melee_attack_hit_box.get_collider()
			if collider.is_in_group("Enemy"):
				collider.apply_central_impulse(melee_attack_hit_box.global_position)
				collider.get_parent().remove_health() 
			if collider.is_in_group("Ghost"):
				collider.hit()

func hit():
	if !is_invincible:
		GameState.player_health -= 1
		is_hit = true
		is_invincible = true
		invincibility_cooldown.start()
		animated_sprite.play("hit")
		await get_tree().create_timer(0.2).timeout
		is_hit = false;
		
func _on_attack_cooldown_timeout():
	is_attacking = false;

func _on_invincibility_cooldown_timeout():
	is_invincible = false
