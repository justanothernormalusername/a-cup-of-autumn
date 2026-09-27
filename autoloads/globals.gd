extends Node

signal deselect_slots
signal hold_output

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
