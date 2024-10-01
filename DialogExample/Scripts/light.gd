extends Node2D

@onready var flickering_timer : Timer = get_node("FlickeringTimer")
@onready var swap_flickering_timing : Timer = get_node("SwapFlickeringTiming")
@onready var point_light : PointLight2D = get_node("PointLight2D")

var random_generator
var is_on : bool = true

@export var flickering_light : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if flickering_light :
		random_generator = RandomNumberGenerator.new()
		flickering_timer.wait_time = random_generator.randf_range(0.2, 0.6)
		flickering_timer.start()
		swap_flickering_timing.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_swap_flickering_timing_timeout():
	flickering_timer.wait_time = random_generator.randf_range(0.2, 0.6)

func _on_flickering_timer_timeout():
	if is_on :
		point_light.energy = 0
		is_on = false
	else :
		point_light.energy = 1
		is_on = true
