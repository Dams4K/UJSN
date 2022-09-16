extends Control

@onready var port_line_edit: LineEdit = %PortLineEdit

var multiplayer_peer = ENetMultiplayerPeer.new()

func _on_host_button_pressed() -> void:
	var port = port_line_edit.text.to_int()
	multiplayer_peer.create_server(port)
	multiplayer.multiplayer_peer = multiplayer_peer
	multiplayer_peer.peer_connected.connect(func(id): add_player(id))
	add_player()


func _on_join_button_pressed() -> void:
	var port = port_line_edit.text.to_int()
	multiplayer_peer.create_client("localhost", port)
	multiplayer.multiplayer_peer = multiplayer_peer


func add_player(id=1):
	pass
