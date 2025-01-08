extends ColorRect

var steam_id: int = 0
var username: String = ""
var last_sent_position: Vector2 = Vector2.ZERO

func setup(_steam_id: int, _username: String) -> void:
	self.steam_id = _steam_id
	self.username = _username

	last_sent_position = position

func _process(delta) -> void:
	if is_local_player():
		handle_input(delta)
		check_and_send_movement()

func handle_input(delta) -> void:
	var movement = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		movement.x += 1
	if Input.is_action_pressed("ui_left"):
		movement.x -= 1
	if Input.is_action_pressed("ui_down"):
		movement.y += 1
	if Input.is_action_pressed("ui_up"):
		movement.y -= 1
	
	movement = movement.normalized() * 300 * delta
	position += movement

func is_local_player() -> bool:
	return Global.steam_id == steam_id

func check_and_send_movement() -> void:
	send_movement_data()
	last_sent_position = position


func send_movement_data() -> void:
	var packet_data = {
		"message": "movement",
		"steam_id": steam_id,
		"position": {
			"x": position.x,
			"y": position.y
		}
	}

	Network.send_p2p_packet(0, packet_data, Steam.P2P_SEND_UNRELIABLE)


func update_remote_position(new_position: Vector2) -> void:
	if !is_local_player():
		position = new_position
