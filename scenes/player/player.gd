extends CharacterBody2D
class_name Player

@export var SPEED = 100
var screen_size
var hovered_item = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	velocity = direction * SPEED
	if direction.length() > 0:
		$AnimatedSprite2D.play("walk")
		if direction.x != 0:
			$AnimatedSprite2D.flip_h = direction.x < 0
	else:
		$AnimatedSprite2D.play("idle")
		
	move_and_slide()
	
func _process(delta: float) -> void:
	update_hover()
	if Input.is_action_just_pressed("pick_up") and hovered_item != null:
		print(hovered_item)
		hovered_item.queue_free()
	
func update_hover():
	var world_mouse_pos = get_global_mouse_position()
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.position = get_global_mouse_position()
	
	var results = space_state.intersect_point(query)
	
	if results.size() > 0:
		hovered_item = results[0].collider
	else:
		hovered_item = null
