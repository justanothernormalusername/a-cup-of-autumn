class_name Inventory
extends Control

const SLOTS_IN_ROW = 3

var SLOT: PackedScene = load("res://scenes/ui/inventory/inventory_slot.tscn")
@onready var SLOT_CONTAINER: GridContainer = $RightPanel/VBoxContainer/MarginContainer/ScrollContainer/GridContainer

@export var ITEMS_PATH := "res://scenes/ui/inventory/items/"
var inventory_items: Array[InventoryItem]

func _init() -> void:
	for file_name in DirAccess.get_files_at(ITEMS_PATH):
		var item: InventoryItem = load(ITEMS_PATH.path_join(file_name))
		item.num = item.START_COUNT
		var display_name := item.DISPLAY_NAME
		
		# Throws debug error if display name already exists
		assert(display_name not in InventoryItem.instantiated_items, "Item already exists!")
		InventoryItem.instantiated_items.append(display_name)
		
		inventory_items.append(item)
	print(inventory_items)

signal update_inventory()

func add_node(item: Node2D):
	var display_name = item.DISPLAY_NAME
	var inventory_item := get_item(display_name)
	if inventory_item:
		inventory_item.add()
	else:
		inventory_item = InventoryItem.new(display_name, load(item.scene_file_path), 1)
		inventory_items.append(inventory_item)
		push_warning("Unregistered item ", inventory_item.DISPLAY_NAME, " added to inventory - will not have a texture!")
	update_inventory.emit()

func get_item(display_name: String) -> InventoryItem:
	if InventoryItem.is_instantiated(display_name):
		var item_index := inventory_items.find_custom(
			func(_item: InventoryItem) -> bool: 
				return _item.DISPLAY_NAME == display_name
		)
		return inventory_items[item_index]
	else:
		return null

func update() -> void:
	var instantiated_items := Globals.inventory.inventory_items
	var items: Array[InventoryItem] = []
	
	# Clears all slots in SLOT_CONTAINER
	for slot in SLOT_CONTAINER.get_children():
		slot.queue_free()
	
	# Filter only InventoryItems with a count > 0
	items.assign(instantiated_items.filter(
		func(_item: InventoryItem) -> bool: 
			return _item.num > 0
	))

	# Sort items by alphabetical order
	items.sort_custom(
		func(a: InventoryItem, b: InventoryItem) -> bool: 
			return a.DISPLAY_NAME < b.DISPLAY_NAME
	)
	for item in items:
		var new_slot: InventorySlot = SLOT.instantiate()
		SLOT_CONTAINER.add_child(new_slot)
		new_slot.set_properties(item)
		new_slot.gui_input.connect(_on_gui_input.bind(new_slot))


# Connected to gui_input signal from Slot
# Additional argument Slot bound to function
func _on_gui_input(event: InputEvent, slot: InventorySlot) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		var node: Item = slot.ITEM.spawn(mouse_pos)
		get_parent().add_sibling(node)
		update()

func visibility(state: bool) -> void:
	visible = state

func _ready() -> void:
	Inventory.update_inventory.connect(update)
	
	# Connect visibility to global signal
	Globals.inventory_visible.connect(visibility)
	
	update()

func _process(_delta: float) -> void:
	mouse_pos = Globals.get_vector_zero() + get_global_mouse_position()
