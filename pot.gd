class_name Pot
extends Node2D

@onready var sprite = $DelectablePot
@onready var thought_bubble = $ThoughtBubble
@onready var item_icon = $ThoughtBubble/ItemIcon
var fill = 0

const ITEM_SCENE = preload("res://scenes/item/item.tscn")

var requested_item: String = ""

func _ready() -> void:
	generate_random_request()

func generate_random_request() -> void:
	var random_item = Globals.available_items.pick_random()
	requested_item = random_item["name"]
	item_icon.texture = random_item["texture"]
	thought_bubble.visible = true

func interact_with_item(item_name: String) -> void:
	print("interact")
	fill += 1
	if fill > 0:
		var boba = {
			"name": "Boba",
			"texture": preload("res://assets/items/boba.png")
		}
	
		var item: Item = ITEM_SCENE.instantiate()
		add_child(item)
		
		item.item_name = boba["name"]
		item.sprite.texture = boba["texture"]
		
		item.position = Vector2(0, 30)
		
		fill = 0
	generate_random_request()
