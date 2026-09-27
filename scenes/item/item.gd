extends StaticBody2D
class_name Item

@onready var sprite = $Sprite2D
var item_name = "Item"

func _ready():
	sprite.apply_scale(Vector2(5, 5))
	sprite.texture = preload("res://assets/items/boba.png")
	
func _on_process():
	pass
