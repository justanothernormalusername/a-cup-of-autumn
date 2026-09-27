extends Control
@onready var texture: TextureRect = $TextureRect
@onready var viewport: Viewport = get_viewport()
@onready var active_camera: Camera2D = viewport.get_camera_2d()
const TARGET_POS := Vector2.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !active_camera:
		return
	if viewport.get_visible_rect().has_point(viewport.get_canvas_transform() * TARGET_POS):
		hide()
	else:
		show()
		var direction := (Vector2.ZERO - active_camera.global_position).normalized()
		var half_width = viewport.size.x / 2
		var half_height = viewport.size.y / 2
		texture.position = direction * min(half_width / abs(direction.x), half_height / abs(direction.y))
