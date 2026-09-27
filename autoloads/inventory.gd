extends Node

@export var ITEMS_PATH := "res://scenes/ui/inventory/items/"
var inventory_items: Dictionary[String, InventoryItem]

var selected_item: InventoryItem

func _init() -> void:
	for file_name in DirAccess.get_files_at(ITEMS_PATH):
		var inventory_item: InventoryItem = load(ITEMS_PATH.path_join(file_name))
		inventory_item.num = inventory_item.START_COUNT
		var display_name := inventory_item.DISPLAY_NAME
		
		# Throws debug error if display name already exists
		assert(display_name not in inventory_items, "Item already exists!")
		
		inventory_items[inventory_item.DISPLAY_NAME] = inventory_item

signal update_inventory()

func add_node(item: Node2D):
	var display_name = item.DISPLAY_NAME
	var inventory_item := get_item(display_name)
	if inventory_item:
		inventory_item.add()
	else:
		inventory_item = InventoryItem.new(display_name, load(item.scene_file_path), 1)
		inventory_items[inventory_item.DISPLAY_NAME] = inventory_item
		push_warning("Unregistered item ", inventory_item.DISPLAY_NAME, " added to inventory - will not have a texture!")
	update_inventory.emit()

func get_item(display_name: String) -> InventoryItem:
	return inventory_items.get(display_name)
