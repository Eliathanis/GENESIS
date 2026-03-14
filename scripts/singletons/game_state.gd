extends Node

# GENESIS Game State Manager
# Manages global game state and persistence

class_name GameState

signal game_state_changed(state_name)
signal player_data_updated(player_id)

enum GameMode {
	WORLD_BUILDING,
	GAME_MASTER,
	PLAYER,
	MENU
}

var current_mode: GameMode = GameMode.MENU
var current_world: String = ""
var players = {}
var world_data = {}
var session_id: String = ""

func _ready():
	generate_session_id()

func generate_session_id():
	var time = Time.get_datetime_string_from_system()
	var random = randi() % 10000
	session_id = "session_%s_%04d" % [time.replace(":", "").replace("-", "").replace(" ", "_"), random]

func set_game_mode(mode: GameMode):
	if current_mode != mode:
		current_mode = mode
		game_state_changed.emit(GameMode.keys()[mode])
		print("Game mode changed to: ", GameMode.keys()[mode])

func is_world_building_mode() -> bool:
	return current_mode == GameMode.WORLD_BUILDING

func is_game_master_mode() -> bool:
	return current_mode == GameMode.GAME_MASTER

func is_player_mode() -> bool:
	return current_mode == GameMode.PLAYER

func load_world(world_path: String):
	# TODO: Implement world loading from file/database
	current_world = world_path
	print("Loading world: ", world_path)
	
	# Example world data structure
	world_data = {
		"name": world_path.get_file(),
		"loaded_at": Time.get_unix_time_from_system(),
		"players": [],
		"npcs": [],
		"objects": []
	}

func save_world():
	if current_world.is_empty():
		push_error("No world loaded to save")
		return false
	
	# TODO: Implement world saving to file/database
	print("Saving world: ", current_world)
	return true

func add_player(player_id: int, player_data: Dictionary):
	players[player_id] = player_data
	player_data_updated.emit(player_id)

func remove_player(player_id: int):
	players.erase(player_id)
	player_data_updated.emit(player_id)

func update_player(player_id: int, key: String, value):
	if players.has(player_id):
		players[player_id][key] = value
		player_data_updated.emit(player_id)

func get_player(player_id: int) -> Dictionary:
	return players.get(player_id, {})

func get_all_players() -> Dictionary:
	return players.duplicate()

func clear_game_state():
	current_mode = GameMode.MENU
	current_world = ""
	players.clear()
	world_data.clear()
	print("Game state cleared")

# Utility functions for game modes
func enter_world_building():
	set_game_mode(GameMode.WORLD_BUILDING)

func enter_game_master():
	set_game_mode(GameMode.GAME_MASTER)

func enter_player_mode():
	set_game_mode(GameMode.PLAYER)

func enter_menu():
	set_game_mode(GameMode.MENU)