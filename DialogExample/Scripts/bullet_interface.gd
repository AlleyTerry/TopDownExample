class_name BulletInterface extends Area2D

const SPEED = 10;
 
var direction : Vector2
var despawn : Timer;

func _ready():
	despawn = Timer.new()
	despawn.wait_time = 0.5
	despawn.one_shot = true
	add_child(despawn)
	despawn.connect("timeout", Callable(self, "_on_timer_timeout"));
	despawn.start()
	
func set_bullet(position:Vector2, targetPosition:Vector2):
	global_position = position;
	direction = (targetPosition - position).normalized();
	rotation = direction.angle();

func _physics_process(delta):
	position += direction * SPEED

func _on_area_entered(area):
	if (area.is_in_group("Enemy")):
		queue_free()
		
func _on_timer_timeout():
	queue_free()
