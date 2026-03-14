extends Node

# GENESIS UI Manager
# Manages user interface and menus

# NOTE: Don't use class_name for autoload singletons
# class_name UIManager

signal ui_screen_changed(screen_name)

var current_screen: String = ""

func _ready():
	print("UI Manager loaded")

func change_screen(screen_name: String, data: Dictionary = {}):
	if current_screen != screen_name:
		current_screen = screen_name
		ui_screen_changed.emit(screen_name)
		print("Changed to screen: ", screen_name)

func show_main_menu():
	change_screen("main_menu")

func show_world_builder():
	change_screen("world_builder")

func show_game_master():
	change_screen("game_master")

func show_player_hud():
	change_screen("player_hud")