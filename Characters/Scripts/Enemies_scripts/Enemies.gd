extends CharacterBody2D

#criando uma nova classe
class_name EnemiesFruits

#region Variables

#player
@onready var player = owner.get_node("%Player_body")

#meu animationPlayer
@export var Anim : AnimationPlayer

#minha textura
@export var Image_texture : Sprite2D

#meu state machine
@export var Maquina_estados : MaquinaEstados

#minha area2d
@export var Area : Area2D

#distancia maxima do jogador
var FOLLOW_DISTANCE : float 

#minha animação atual
var Anim_atual : String = ""

#boleano que vereficara se eu tenho algum efeito
var Effect : bool = false

#distancia entre eu e o jogador
var distance_player : float

#vida do inimigo
var Enemie_life : int

#direção do inimigo
var Enemie_direction : Vector2

#velocidade
var Enemie_vel : float

#endregion

#region Methods

#método que rodara quando eu for instanciado
func _init() -> void:
	
	visible = false #fico invisivel

################################################################################

#endregion

#region My Methods

#criando método para trocar minha animação
func Troca_animacao(_Nova_animacao : String):
	
	#SE minha animação atual NÃO FOR igual a minha nova animação, eu executo o código
	if Anim_atual != _Nova_animacao:
		
		#minha animação atual é igual a minha nova animação
		Anim_atual = _Nova_animacao
	
	##print("A animação atual é " + Anim_atual)
	
	#SE a animação atual for uma string vazia, eu executo o código
	if Anim_atual != "": Anim.play(Anim_atual) #rodando minha animação atual

################################################################################

#criando um método que mudara minha direção com base na velocity
func Flip_Direcao():
	
	#SE minha velocity.x for menor que 0, eu executo o código
	if sign(velocity.x) < 0.0: #sign vai retorna apenas 1, 0 ou -1 (olha a documentação)
		
		#minha imagem fica voltada para a esquerda
		Image_texture.flip_h = true

		return #retorna
	

	#minha imagem fica voltada para a direita
	Image_texture.flip_h = false

################################################################################

#endregion
