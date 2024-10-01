extends StaticBody2D

#checks whether or not the bottle has been clicked
var selected = false
#we use this in our global script to know which bottle we are using 
var bottleType = 2 #slime

func _ready():
	$AnimatedSprite2D.play("default")


#done by clicked on Area2D > Node (Next to Inscpector) > CollisionObject2D > input_event
#this happens when this area is clicked
#remember to go into project settings and add a "click"
func _on_area_2d_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		#makes the global bottle this bottle
		Global.BottleSelected = bottleType
		selected = true
		
func _physics_process(delta):
	if selected:
		global_position =lerp(global_position, get_global_mouse_position(), 25 * delta)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			selected = false
