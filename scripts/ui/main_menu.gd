extends Control

class_name MainMenu

@onready var host_button: Button = $Background/Buttons/HostButton
@onready var join_button: Button = $Background/Buttons/JoinButton
@onready var world_builder_button: Button = $Background/Buttons/WorldBuilderButton
@onready var exit_button: Button = $Background/Buttons/ExitButton

func _ready():
	print("Main Menu loaded")
	
	# Connect buttons
	host_button.pressed.connect(_on_host_pressed)
	join_button.pressed.connect(_on_join_pressed)
	world_builder_button.pressed.connect(_on_world_builder_pressed)
	exit_button.pressed.connect(_on_exit_pressed)

func _on_host_pressed():
	print("Host button pressed")
	# TODO: Implement hosting logic
	get_tree().change_scene_to_file("res://scenes/world/world_builder.tscn")

func _on_join_pressed():
	print("Join button pressed")
	# TODO: Implement joining logic
	get_tree().change_scene_to_file("res://scenes/world/player_world.tscn")

func _on_world_builder_pressed():
	print("World Builder button pressed")
	get_tree().change_scene_to_file("res://scenes/world/world_builder.tscn")

func _on_exit_pressed():
	print("Exit button pressed")
	get_tree().quit()