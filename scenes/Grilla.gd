extends TileMap

class_name Grilla

signal hacia_morir

onready var media_grilla_tamano = get_cell_size() / 2

onready var grilla_tamano: Vector2 = Vector2(32,24)
var grilla: Array

func _ready():
	setup_grilla()

func setup_grilla() -> void:
	grilla = []
	
	for x in range(grilla_tamano.x):
		grilla.append([])
		for y in range(grilla_tamano.y):
			grilla[x].append(null)
			
func get_entidad_de_celda(grilla_pos: Vector2) -> Node2D:
	return grilla[grilla_pos.x][grilla_pos.y] as Node2D

func set_entidad_en_celda(entidad: Node2D, grilla_pos: Vector2) -> void:
	grilla[grilla_pos.x][grilla_pos.y] = entidad

func colocar_entidad(entidad: Node2D, grilla_pos: Vector2) -> void:
	set_entidad_en_celda(entidad, grilla_pos)
	entidad.set_position(map_to_world(grilla_pos) + media_grilla_tamano)
	
func colocar_entidad_posicion_random(entidad: Node2D) -> void:
	var tiene_random_pos: bool = false
	var random_grilla_pos: Vector2
	
	while tiene_random_pos == false:
		var temp_pos: Vector2 = Vector2(randi() % int(grilla_tamano.x), randi() % int(grilla_tamano.y))
		if get_entidad_de_celda(temp_pos) == null:
			random_grilla_pos = temp_pos
			tiene_random_pos = true
	
	colocar_entidad(entidad, random_grilla_pos)
	
func mover_entidad_en_direccion(entidad: Node2D, direccion: Vector2) -> void:
	var antigua_grilla_pos: Vector2 = world_to_map(entidad.position)
	var nueva_grilla_pos: Vector2 = antigua_grilla_pos + direccion
	
	if !esta_celda_dentro_limites(nueva_grilla_pos):
		setup_grilla()
		emit_signal("hacia_morir")
		return
	
	set_entidad_en_celda(null, antigua_grilla_pos)
	colocar_entidad(entidad, nueva_grilla_pos)

func esta_celda_dentro_limites(celda_pos: Vector2) -> bool:
	if(celda_pos.x < grilla_tamano.x and celda_pos.x >= 0 \
		#contrinua abajo
		and celda_pos.y < grilla_tamano.y and celda_pos.y >= 0):
			return true
	else:
		return false