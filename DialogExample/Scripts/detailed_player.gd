class_name DetailedPlayer extends AbstractPlayer

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var animated_sprite : AnimatedSprite2D = get_node("AnimatedSprite2D")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("player_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("player_left", "player_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction < 0:
		animated_sprite.set_flip_h(true)
	elif direction > 0: 
		animated_sprite.set_flip_h(false)

	if direction != 0:
		animated_sprite.play("walk")
	else:
		animated_sprite.play("idle")
	move_and_slide()
