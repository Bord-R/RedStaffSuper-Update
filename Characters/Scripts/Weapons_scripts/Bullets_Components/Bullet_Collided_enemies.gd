extends Node

class_name CollidedEnemies #criando para ser usado como node

#region Variables

#meu pai
@onready var Bullet : Area2D = get_parent()

#efeito de fogo
@onready var Effect_Fire : PackedScene = preload("res://Characters/cines/EffectsParticles/fire_gun_particles.tscn")

#minha restrição
@export var Restriction_State : bool = true

#se eu posso destruir meu pai
@export var Destroy_Bool : bool = true

#força do screen shake
@export_range(0.0,10.0,0.5) var Shake : float = 2.5

@export var Is_FireEffect : bool = true  #se eu posso soltar um efeito de fogo quando colidir com um inimigo

#meu valor inicial
const VALUE_INI : int = 1

#meu valor final
const VALUE_FIN : int = 0

#valor de espera em segundos
const SECS : float = 0.25

#inimigo
var Enemy : EnemiesFruits = null

#estado atual do inimigo
var Atual_State : Estado = null

#estado do inimigo
var State_Enemy : Dictionary = {}

#nome do estado que o inimigo ira quando colidir comigo
var Hit_State : String = "estadohit"

#tween para animação
var Collided_Tween 

#endregion 

#region Methods

#método que rodara quando eu for iniciado
func _ready() -> void:

	#conecto o sinal ao método
	VM.Conected_Signals(Bullet.area_entered, Area_Collided)

################################################################################

#endregion

#region My Methods

#método que rodara quando o sinal area entered for emitido
func Area_Collided( _area : Area2D):
	
	#SE o corpo for um inimigo
	if _area.get_parent() is EnemiesFruits:

		#configurando  umas paradas pra facilitar as chamadas posteriores
		Enemy = _area.get_parent() #inimigo
		Atual_State = Enemy.Maquina_estados.Estado_Atual #estado atual do inimigo

		#tremo a tela
		Bullet.Screen_shake.trigger_shake(Shake)

		#método que dara um efeito de brilho
		Tween_Shader()

		Create_FireEffect() #crio um efeito de fogo

		#SE o eu tenho restrições a cerca dos estados do inimigo
		if Restriction_State == true:

			#SE o estado atual do inimigo for um estadohit ou um estadodash
			if !Atual_State is EstadoHit and !Atual_State is EstadoDash:

				#aplico o dano
				Aplicate_Damage(Enemy)

		elif Restriction_State == false: #SE NÃO (ou seja, se eu posso só dar dano sem restrições)

			#aplico o dano
			Aplicate_Damage(Enemy)

		Auto_Destroy(Destroy_Bool) #destruo o projetil se eu tiver permição

################################################################################

#método que aplicara dano do inimigo
#parametros,_Alvo : meu alvo
func Aplicate_Damage(_Alvo : EnemiesFruits):

	#chamo o método do alvo para ele tomar dano
	_Alvo.Take_Damaged(
		Bullet.Damage,
		Bullet.global_position,
		Bullet.Knockback,
		Bullet.Super_Acresim,
		Bullet.Points_Acresim
	)

################################################################################

#método que criara um efeito de fogo
func Create_FireEffect():

	if !Is_FireEffect: return #SE eu não posso criar um efeito de fogo, eu retorno

	#instancio o efeito de fogo
	var _Effect_Instance = Effect_Fire.instantiate()

	#configuro a posição do efeito para ser a mesma do meu pai
	_Effect_Instance.global_position = Bullet.global_position

	_Effect_Instance.rotation = Bullet.rotation

	_Effect_Instance.get_child(0).emitting = true #ativo a emissão do meu efeito

	#adiciono ele como filho do meu pai
	get_tree().current_scene.add_child(_Effect_Instance)

################################################################################

#método que ira destroir o projetil
func Auto_Destroy(_permit : bool):
	#SE eu posso destruir, eu destruo
	if _permit == true: Bullet.Effect_explodion()

################################################################################

#método que ira fazer uma animação
func Tween_Shader():
	
	#SE esse tween existir
	if Collided_Tween:
		#eu deleto ele
		Collided_Tween.kill()

	#crio um tween
	Collided_Tween = create_tween()

	#conecto ele ao node pai para ele ser liberado junto do pai
	Collided_Tween.bind_node(Bullet)

	#interpolo o mod shader
	Collided_Tween.tween_method(Mod_Shader, VALUE_INI, VALUE_FIN, SECS)

################################################################################

#método que ira modificar o shader de bullet
func Mod_Shader(_value):
	
	if Bullet.texture.material:
		#modificando o shader
		Bullet.texture.material.set("shader_parameter/float_flash", _value)

################################################################################

#endregion
