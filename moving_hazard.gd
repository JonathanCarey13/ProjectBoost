extends AnimatableBody3D

# this is what we'll use to assign an x,y,z position for where our hazard will end
@export var destination: Vector3
# this is how long it will take for our hazard to move to the above given coordinates
@export var duration: float = 1.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = create_tween()
	tween.set_loops()
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "global_position", global_position + destination, duration)
	tween.tween_property(self, "global_position", global_position, duration)

func starting_harard() -> void:
	var tween = create_tween()
	tween.tween_property(self, "global_position", global_position + destination, duration)

func returning_harzard() -> void:
	var tween = create_tween()
	tween.tween_property(self, "global_position", global_position, duration)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
