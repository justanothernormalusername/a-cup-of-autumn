extends CharacterBody2D
class_name Player

@export var SPEED = 100
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	velocity = direction * SPEED
	if direction.length() > 0:
		$AnimatedSprite2D.play("walk")
		if direction.x != 0:
			$AnimatedSprite2D.flip_h = direction.x < 0
	else:
		$AnimatedSprite2D.play("idle")
		
	move_and_slide()
