extends Node2D

@onready var sprite2d: Sprite2D = $Sprite2D
@onready var wait_timer: Timer = $WaitTimer
@onready var shadow: Sprite2D = $Shadow

func _ready() -> void:
	wait_timer.wait_time = randf_range(1.0, 3.0)
	wait_timer.one_shot = true
	wait_timer.timeout.connect(_animate_one_hop)
	wait_timer.start()
	
func _animate_one_hop() -> void:
	const HOP_DURATION := 0.25
	const HALF_HOP_DURATION := HOP_DURATION / 2.0
	
	var random_direction := Vector2(1.0, 0.0).rotated(randf() * 2.0 * PI)
	var land_position := random_direction * randf_range(0.0, 30.0)
	
	var tween := create_tween().set_parallel()
	tween.tween_property(sprite2d, "position:x", land_position.x, HOP_DURATION)
	tween.tween_property(shadow, "position", land_position, HOP_DURATION)
	
	tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_OUT)
	const JUMP_HEIGHT := 16.0
	tween.tween_property(sprite2d, "position:y", land_position.y - JUMP_HEIGHT, HALF_HOP_DURATION)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(sprite2d, "position:y", land_position.y, HALF_HOP_DURATION)
	
	wait_timer.wait_time = randf_range(1.0, 3.0)
	tween.finished.connect(wait_timer.start)
	
