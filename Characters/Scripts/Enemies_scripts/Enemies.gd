extends CharacterBody2D

#criando uma nova classe
class_name EnemiesFruits

#region Variables

signal Damaged()

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
@export var FOLLOW_DISTANCE : float 

#minha animação atual
var Anim_atual : String = ""

#boleano que vereficara se eu tenho algum efeito
var Effect : bool = false

#distancia entre eu e o jogador
var distance_player : float

#vida do inimigo
@export var Enemie_life : int :
	#defido como uma variavel do tipo setter (definir)
	set(value): #toda vez que eu mudo o valor dessa variavel
		Enemie_life = value #ela é atualizada

#direção do inimigo
var Enemie_direction : Vector2

#velocidade
@export var Enemie_vel : float

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

#criando um método que fara eu tomar dano
func Take_Damaged(
	_damage : int,
	_knock_dir : Vector2,
	_knock_vel : float,
	_acresim_super : int,
	_acresim_points : float
	):
	
	Enemie_life -= _damage #tomo dano

	Maquina_estados.Troca_Estado("estadohit") #vou para o estado de hit

	Maquina_estados.Meus_Estados["estadohit"].Knock_dir = _knock_dir #mudo a direção do hit

	Maquina_estados.Meus_Estados["estadohit"].Knock_vel = _knock_vel #mudo a velocidade do hit
	
	Damaged.emit() #emito o sinal que eu tomei dano

	if Enemie_life <= 0: #SE minha vida acabar

		#mudo a quantidade de pontos que eu darei
		Maquina_estados.Meus_Estados["estadomorto"].Quantity_Points = _acresim_points

		#mudo a quantidade de pontos de super que darei
		Maquina_estados.Meus_Estados["estadomorto"].Quantity_Super = _acresim_super

################################################################################

#endregion
