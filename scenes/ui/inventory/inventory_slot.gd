class_name InventorySlot
extends Panel

@onready var BACKGROUND = get_node("Background")
@onready var TEXTURE = get_node("Texture")
@onready var COUNT = get_node("Count")

var ITEM: InventoryItem

func set_properties(item: InventoryItem) -> void:
	name = item.DISPLAY_NAME
	TEXTURE.texture = item.ITEM_TEXTURE
	COUNT.text = str(item.num)
	ITEM = item
