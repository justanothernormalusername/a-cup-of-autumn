extends Node2D

const ITEM_SCENE = preload("res://scenes/item/item.tscn")
const CRITTER_SCENE = preload("res://scenes/critter/critter.tscn")

@onready var spawned_items_node = $SpawnedItems
@onready var item_spawn_points_node = $ItemSpawnPoints
@onready var critter_spawn_points_node = $CritterSpawnPoints
@onready var spawned_critters_node = $SpawnedCritters

var available_items: Array[Dictionary] = [
	{
		"name": "Boba",
		"texture": preload("res://assets/items/boba.png")
	},
	{
		"name": "Carrot",
		"texture": preload("res://assets/items/carrot.png")
	},
	{
		"name": "Potato",
		"texture": preload("res://assets/items/potato.png")
	},
	{
		"name": "Sweet Potato",
		"texture": preload("res://assets/items/sweet_potato.png")
	},
	{
		"name": "Beet",
		"texture": preload("res://assets/items/beet.png")
	}
]

var spawned_items = {}
var spawned_critters = {}

func spawn_item(marker) -> void:
	var random_type = available_items.pick_random()
	
	var item: Item = ITEM_SCENE.instantiate()
	spawned_items_node.add_child(item)
	
	item.item_name = random_type["name"]
	item.sprite.texture = random_type["texture"]
	
	item.position = marker.position + Vector2(randi_range(-4, 4) * 8, randi_range(-4, 4) * 8)
	spawned_items[marker] = item
	
func spawn_critter(marker) -> void:
	var critter: Critter = CRITTER_SCENE.instantiate()
	spawned_critters_node.add_child(critter)
	
	critter.position = marker.position + Vector2(randi_range(-4, 4) * 8, randi_range(-4, 4) * 8)
	critter.generate_random_request(available_items)
	
	spawned_critters[marker] = critter

func _ready() -> void:
	for marker: Marker2D in item_spawn_points_node.get_children():
		var spawn_timer = Timer.new()
		spawn_timer.wait_time = randi_range(1, 30)
		spawn_timer.one_shot = false 
		
		marker.add_child(spawn_timer)
		spawn_timer.timeout.connect(func():
			spawn_timer.wait_time = randi_range(25, 40)
			spawn_item(marker)
		)
		spawn_timer.start()
	
	for marker: Marker2D in critter_spawn_points_node.get_children():
		var spawn_timer = Timer.new()
		spawn_timer.wait_time = randi_range(1, 5)
		spawn_timer.one_shot = false 
		
		marker.add_child(spawn_timer)
		spawn_timer.timeout.connect(func():
			if (marker not in spawned_critters) or not is_instance_valid(spawned_critters[marker]):
				spawn_timer.wait_time = randi_range(10, 20)
				spawn_critter(marker)
		)
		spawn_timer.start()
	
func _process(delta: float) -> void:
	pass
