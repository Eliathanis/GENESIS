extends Node

# GENESIS Network Manager
# Handles multiplayer connections for the game

class_name NetworkManager

signal player_connected(player_id, player_name)
signal player_disconnected(player_id)
signal connection_established()
signal connection_failed()

const DEFAULT_PORT = 9080
const MAX_PLAYERS = 8

var peer: ENetMultiplayerPeer = null
var players = {}  # player_id -> player_data

func _ready():
	multiplayer.peer_connected.connect(_on_player_connected)
	multiplayer.peer_disconnected.connect(_on_player_disconnected)
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	multiplayer.connection_failed.connect(_on_connection_failed)

func host_game(player_name: String):
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(DEFAULT_PORT, MAX_PLAYERS)
	if error != OK:
		push_error("Failed to create server: " + str(error))
		connection_failed.emit()
		return false
	
	multiplayer.multiplayer_peer = peer
	register_player(1, player_name)  # Host is player 1
	connection_established.emit()
	return true

func join_game(ip: String, player_name: String):
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_client(ip, DEFAULT_PORT)
	if error != OK:
		push_error("Failed to create client: " + str(error))
		connection_failed.emit()
		return false
	
	multiplayer.multiplayer_peer = peer
	return true

func register_player(player_id: int, player_name: String):
	players[player_id] = {
		"name": player_name,
		"id": player_id,
		"connected_at": Time.get_unix_time_from_system()
	}
	player_connected.emit(player_id, player_name)

func _on_player_connected(player_id: int):
	print("Player connected: ", player_id)
	# Request player info from the new player
	rpc_id(player_id, "request_player_info")

func _on_player_disconnected(player_id: int):
	print("Player disconnected: ", player_id)
	players.erase(player_id)
	player_disconnected.emit(player_id)

func _on_connected_to_server():
	print("Connected to server")
	# Send our player info to the server
	rpc_id(1, "register_player_on_server", multiplayer.get_unique_id(), "Player")

func _on_connection_failed():
	print("Connection failed")
	connection_failed.emit()

@rpc("any_peer", "reliable")
func request_player_info():
	var player_id = multiplayer.get_remote_sender_id()
	# This would be implemented in player script
	pass

@rpc("any_peer", "reliable")
func register_player_on_server(player_id: int, player_name: String):
	if multiplayer.is_server():
		register_player(player_id, player_name)

func get_player_count() -> int:
	return players.size()

func get_player_list() -> Array:
	return players.values()

func disconnect_all():
	if peer:
		peer.close()
	players.clear()