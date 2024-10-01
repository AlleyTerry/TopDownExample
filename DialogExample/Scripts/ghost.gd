extends Ghost

const SPEED = 50

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var aggro_range : Area2D = $AggroRange

var player_in_range : AbstractPlayer
var dead : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !dead :
		if player_in_range == null:
			pass
		else:
			var how_far_is_player = player_in_range.position - position
			if how_far_is_player.abs().x < 20 && how_far_is_player.abs().y < 20:
				pass
			else :
				var move_to = (how_far_is_player).normalized()
				sprite.set_flip_h(move_to.x > 0)
				emit_signal("facing_direction_changed", !sprite.flip_h)
				
				position += (move_to * delta) * SPEED;
		rotation = 0
	
func _on_attack_area_body_entered(body):
	if body is AbstractPlayer:
		(body as AbstractPlayer).hit()

func _on_aggro_range_body_entered(body):
	if body is AbstractPlayer:
		player_in_range = body

func _on_aggro_range_body_exited(body):
	player_in_range = null

func hit():
	if (!dead):
		dead = true
		GameState.number_of_ghosts -= 1
		sprite.play("dead")
		await get_tree().create_timer(0.5).timeout
		queue_free()
	
