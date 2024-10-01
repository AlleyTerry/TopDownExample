extends Area2D

@export var ghost : Ghost
@export var facing_collision : FacingCollision2D

# Called when the node enters the scene tree for the first time.
func _ready():
	ghost.connect("facing_direction_changed", Callable(self, "_on_facing_direction_changed"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_facing_direction_changed(facing_right :bool):
	if facing_right:
		facing_collision.position = facing_collision.facing_right_position
	else:
		facing_collision.position = facing_collision.facing_left_position
