extends Node2D

const ITEM_SCENE = preload("res://scenes/item/item.tscn")

@onready var spawned_items_node = $SpawnedItems
@onready var item_spawn_points_node = $ItemSpawnPoints
var item_spawn_points = []

func spawn_item(marker) -> void:
	var item: Item = ITEM_SCENE.instantiate()
	item.position = marker.position + Vector2(randi_range(-4, 4), randi_range(-4, 4))
	spawned_items_node.add_child(item)
	print("SPAWNED")

func _ready() -> void:
	for marker: Marker2D in item_spawn_points_node.get_children():
		var spawn_timer = Timer.new()
		spawn_timer.wait_time = randi_range(1, 10)
		spawn_timer.one_shot = false 
		
		marker.add_child(spawn_timer)
		spawn_timer.timeout.connect(func():
			spawn_timer.wait_time = randi_range(1, 10)
			spawn_item(marker)
		)
		spawn_timer.start()
	
func _process(delta: float) -> void:
	pass
