extends Node

#criando uma classe para ser usado como node
class_name HitReduction #reduzindo ao sofrer dano

#region Variables

#Pai
@onready var Pai : Bala = get_parent()

#animação
@export var Anim : AnimationPlayer

#minha velocidade original
var Original_vel : float = 2.5

#minha velocidade reduzida
var Reduction_vel : float = 0.1

#variavel de controle
var Bool_Reduction : bool = false

#endregion

#region Methods

#método que rodara no inicio do game
func _ready() -> void:
	
	#conectando os sinais aos seus métodos
	VM.Conected_Signals(Anim.animation_finished, Animacao_Finalizada)
	VM.Conected_Signals(Pai.area_entered, Area_detectada)

################################################################################

#método que rodara a cada frame do game
func _process(_delta: float) -> void:
	
	#SE eu estou reduzindo
	if Bool_Reduction == false:
		
		Pai.Vel = Original_vel #minha velocidade volta ao normal
	
	#SE NÃO, SE eu NÃO estou reduzindo
	elif Bool_Reduction == true:
		
		Pai.Vel =  Reduction_vel #minha velocidade é reduzida

################################################################################

#método que rodara ao encostar em uma area
func Area_detectada(_area : Area2D):
	
	#SE o pai da area que eu interagi for um Enemie fruit E o limite for menor que o limite maximo 
	if _area.get_parent() is EnemiesFruits:
		
		#eu reduzo minha velocidade
		Bool_Reduction = true
		
		#toco a aniamção "hit"
		Anim.play("hit")

################################################################################

#método que rodara quando a animação acabar
func Animacao_Finalizada(_anim : StringName):
	
	#SE o nome da animação for igual a hit
	if _anim == "hit":
		
		#posso parar de reduzir
		Bool_Reduction = false

################################################################################

#endregion
