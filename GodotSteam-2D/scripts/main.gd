extends Control

@onready var player_scene = preload('res://scenes/player/player.tscn')

@onready var lobby_id = $MarginContainer/VBoxContainer/VBoxContainer/LobbyID
@onready var lobby_current_members = $MarginContainer/VBoxContainer/PlayerContainer/VBoxContainer/MarginContainer/VBoxContainer
@onready var chat_input = $MarginContainer/VBoxContainer/ChatContainer/VBoxContainer/LineEdit
@onready var chat = $MarginContainer/VBoxContainer/ChatContainer/VBoxContainer/ScrollContainer/MarginContainer/VBoxContainer

var active_players = {}

func _ready() -> void:
	Steam.lobby_joined.connect(_on_lobby_joined)
	Steam.lobby_message.connect(_on_lobby_message)

	Network.lobby_members_updated.connect(_update_player_list)


func _on_host_button_pressed() -> void:
	Network.create_lobby()


func _on_join_button_pressed() -> void:
	var id: int = int(lobby_id.text)
	Network.join_lobby(id)


func _on_lobby_joined(_this_lobby_id: int, _permissions: int, _locked: bool, _response: int):
	_update_player_list()


func send_chat_message(message: String):
	if Network.lobby_id != 0:
		var sent = Steam.sendLobbyChatMsg(Network.lobby_id, message)

		if not sent:
			Steam.lobby_message.emit(Network.lobby_id, Global.steam_id, message, 0)


func _on_lobby_message(_lobby_id: int, user_id: int, message: String, _chat_type: int):
	var sender_name = Steam.getFriendPersonaName(user_id)
	display_message(sender_name, message)
	
	if user_id == Global.steam_id:
		chat_input.clear()


func _update_player_list():
	var lobby_members = Network.lobby_members

	for member in lobby_current_members.get_children():
		member.queue_free()

	for lobby_member in lobby_members:
		var label: Label = Label.new()
		label.text = str(lobby_member.steam_name)
		lobby_current_members.add_child(label)

	for player in Network.lobby_members:
		if not active_players.has(player["steam_id"]):
			spawn_player(player["steam_id"], player["steam_name"])


func display_message(sender: String, message: String):
	var chat_label = Label.new()
	chat_label.text = sender + ": " + message
	chat.add_child(chat_label)


func spawn_player(steam_id: int, username: String):
	var player_instance = player_scene.instantiate()
	player_instance.setup(steam_id, username)
	add_child(player_instance)
	active_players[steam_id] = player_instance
