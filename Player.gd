extends RigidBody3D

## How much vertical force to apply when moving.
@export_range(750.0, 3000.0) var thrust: float = 1000.0

## How much torque force to apply to the ship.
@export_range(50.0, 300.0) var torque_thrust: float = 100.0

var is_transitioning: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
		apply_central_force(basis.y * delta * thrust)
		
	if Input.is_action_pressed("rotate_left"):
		apply_torque(Vector3(0.0, 0.0, torque_thrust * delta))
		
	if Input.is_action_pressed("rotate_right"):
		apply_torque(Vector3(0.0, 0.0, -torque_thrust * delta))


func _on_body_entered(body: Node) -> void:
	if is_transitioning == false:
		if "Goal" in body.get_groups():
			complete_level(body.file_path)     
		if "Crash" in body.get_groups():
			crash_sequence()

func crash_sequence() -> void:
	print("KABOOM!")
	# by setting the process to false, it halts all _process functions so we can't keep controlling our player after the goal is reached
	set_process(false)
	# we're changing the is_transitioning var so it tells the signal _on_body_entered to stop processing which whill stop the crash or goal sequences from being called repeated and displaying the string multiple times
	is_transitioning = true
	var tween = create_tween()
	tween.tween_interval(1.0)
	tween.tween_callback(get_tree().reload_current_scene)

func complete_level(next_level_file: String) -> void:
	print("You win!")
	set_process(false)
	# same as line 34, stops the collision signal so we don't get multiple strings displaying
	is_transitioning = true
	var tween = create_tween()
	tween.tween_interval(1.0)
	tween.tween_callback(
		get_tree().change_scene_to_file.bind(next_level_file)
	)
