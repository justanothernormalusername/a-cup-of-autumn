extends Node2D


@onready var canvas_layer = $CanvasLayer
@onready var canvas_modulate = $CanvasModulate
@onready var ui = $CanvasLayer/ClockGui

func _ready() -> void:
	canvas_modulate.time_tick.connect(ui.set_daytime)
