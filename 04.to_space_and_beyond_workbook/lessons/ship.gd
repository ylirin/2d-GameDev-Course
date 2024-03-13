extends Sprite2D

var velocity:= Vector2(1000,0)

func _process(delta: float) -> void:
	position += velocity * delta
	rotation = velocity.angle()
