extends CharacterBody2D
class_name Critter

@onready var sprite = $Sprite2D
@onready var thought_bubble = $ThoughtBubble
@onready var item_icon = $ThoughtBubble/ItemIcon

var nickname: String = "Pip"
var requested_item: String = ""

func _ready() -> void:
	sprite.modulate = Color(randf(), randf(), randf())
	
func _process(delta: float) -> void:
	pass
	
func generate_random_request(available_items) -> void:
	var random_item = available_items.pick_random()
	requested_item = random_item["name"]
	item_icon.texture = random_item["texture"]
	thought_bubble.visible = true
	
func interact_with_item(item_name: String) -> void:
	if item_name == requested_item:
		satisfy_request()
	
func satisfy_request() -> void:
	thought_bubble.visible = false
	
