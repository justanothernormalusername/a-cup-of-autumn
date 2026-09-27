class_name InventorySlot
extends Panel

@onready var texture_node = get_node("Texture")
@onready var count_node = get_node("Count")

var display_item: InventoryItem

func set_properties(inventory_item: InventoryItem) -> void:
	name = inventory_item.DISPLAY_NAME
	texture_node.texture = inventory_item.ITEM_TEXTURE
	count_node.text = str(inventory_item.num)
	display_item = inventory_item

func _on_mouse_entered() -> void:
	self.modulate = Color(1.0, 1.0, 1.0, 0.7)

func _on_mouse_exited() -> void:
	self.modulate = Color(1.0, 1.0, 1.0, 1.0)
