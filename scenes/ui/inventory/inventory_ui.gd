extends Control

const SLOTS_IN_ROW = 3
var SLOT: PackedScene = load("res://scenes/ui/inventory/inventory_slot.tscn")
@onready var SLOT_CONTAINER: GridContainer = $RightPanel/VBoxContainer/MarginContainer/ScrollContainer/GridContainer

func update() -> void:
	var display_items := Inventory.inventory_items.values()
	
	# Clears all slots in SLOT_CONTAINER
	for slot in SLOT_CONTAINER.get_children():
		slot.queue_free()
	
	# Sort items by alphabetical order
	display_items.sort_custom(
		func(a: InventoryItem, b: InventoryItem) -> bool: 
			return a.DISPLAY_NAME < b.DISPLAY_NAME
	)
	
	for display_item in display_items:
		# Filter only InventoryItems with a count > 0
		if display_item.num > 0:
			var new_slot: InventorySlot = SLOT.instantiate()
			SLOT_CONTAINER.add_child(new_slot)
			new_slot.set_properties(display_item)
			# Connects InputEvent for slot to _on_gui_input function with new_slot as an additional argument
			new_slot.gui_input.connect(_on_gui_input.bind(new_slot))


# Connected to gui_input signal from Slot
# Additional argument Slot bound to function
func _on_gui_input(event: InputEvent, slot: InventorySlot) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
		Inventory.selected_item = slot.display_item
		Globals.deselect_slots.emit()
		slot.select()

func visibility(state: bool) -> void:
	visible = state

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Inventory.update_inventory.connect(update)
	update()
