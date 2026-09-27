class_name InventorySlot
extends Panel

@onready var background_node = $Background
@onready var texture_node = $Background/Texture
@onready var count_node = $Background/Count
@onready var overlay = $Overlay

var display_item: InventoryItem
var is_selected: bool

func set_properties(inventory_item: InventoryItem) -> void:
	name = inventory_item.DISPLAY_NAME
	texture_node.texture = inventory_item.ITEM_TEXTURE
	count_node.text = str(inventory_item.num)
	display_item = inventory_item
	Globals.deselect_slots.connect(deselect)

func select() -> void:
	is_selected = true
	overlay.show()

func deselect() -> void:
	is_selected = false
	overlay.hide()


func _on_mouse_entered() -> void:
	background_node.modulate = Color(1.0, 1.0, 1.0, 0.7)

func _on_mouse_exited() -> void:
	background_node.modulate = Color(1.0, 1.0, 1.0, 1.0)
