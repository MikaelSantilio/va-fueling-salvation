extends Node

var coins : int = 0
var winner_screen_id : int = 0
var die_screen_id : int
var pause_screen_id : int
var other_screen_open : = false
var level_id : int
var current_level : String
var global_coins : int = 0
var global_hp : int = 0
var player_speed_kmh : int = 0
var player_bullets : int = 0
var players : Dictionary = {
		"police_car": {
			name = "Carro de polícia",
			path = "res://assets/objects/vehicles/police_car.tscn"
		},
		"sport": {
			name = "Carro Esporte",
			path = "res://assets/objects/vehicles/sport.tscn"
		},
		"monster": {
			name = "Carro Monstro",
			path = "res://assets/objects/vehicles/monster.tscn"
		},
		"jeep": {
			name = "Jipe",
			path = "res://assets/objects/vehicles/jeep.tscn"
		}
	}
var vehicle_selected : Dictionary = players["monster"]
var coin_sound
func play_coin_sound():
	coin_sound.play()
