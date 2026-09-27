extends Control

const TARGET_POS := Vector2.ZERO
const PADDING := 20.0

@onready var texture: TextureRect = $TextureRect
@onready var viewport: Viewport = get_viewport()
@onready var active_camera: Camera2D = viewport.get_camera_2d()

@onready var top_right_offset := Vector2(viewport.size/2)
@onready var half_width: float = (viewport.size.x - PADDING)/ 2
@onready var half_height: float = (viewport.size.y - PADDING)/ 2

@onready var size_offset := texture.size/2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !active_camera:
		return
	if viewport.get_visible_rect().has_point(viewport.get_canvas_transform() * TARGET_POS):
		hide()
	else:
		show()
		var direction := (Vector2.ZERO - active_camera.global_position).normalized()
		position = direction * min(abs(half_width / direction.x), abs(half_height / direction.y)) + top_right_offset - size_offset
		texture.rotation = direction.angle()
		
