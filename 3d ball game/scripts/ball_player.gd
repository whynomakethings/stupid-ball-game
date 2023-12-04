extends CharacterBody3D

const SPEED = 8.0
const JUMP_VELOCITY = 4.5
var velocity_cunt = Vector3(0,0,0)
const ROTSPEED = 7
 

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backwards")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	if Input.is_action_pressed("forward"):
		velocity.x -= SPEED * delta
		$MeshInstance3D.rotate_x(deg_to_rad(-ROTSPEED))
	elif Input.is_action_pressed("backwards"):
		velocity.x += SPEED * delta
		$MeshInstance3D.rotate_x(deg_to_rad(ROTSPEED))
	if Input.is_action_pressed("left"):
		velocity.z += SPEED * delta
		$MeshInstance3D.rotate_z(deg_to_rad(ROTSPEED))
	elif Input.is_action_pressed("right"):
		velocity.z -= SPEED * delta
		$MeshInstance3D.rotate_z(deg_to_rad(-ROTSPEED))



func _on_enemy_1_body_entered(body):
	if body.name == 'CharacterBody3D':
		get_tree().change_scene_to_file("res://menu/game_over_screen.tscn")





func _on_fall_net_body_entered(body):
	if body.name == 'CharacterBody3D':
		get_tree().change_scene_to_file("res://menu/game_over_screen.tscn")


func _on_flag_win_body_entered(body):
	if body.name == 'CharacterBody3D':
		get_tree().change_scene_to_file("res://menu/well_done.tscn")
