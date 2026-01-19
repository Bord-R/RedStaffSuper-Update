extends Node

#criando classe para ser usado como node
class_name ImpulseMovBullet #impulso na movimentação

#region Variables

#valor que aumentara minha velocidade
@export var ACRESIMO : float = 1.5

#suavição para um lerp
@export var SUAVIZACAO : float = 0.5

#referencia  ao node pai
@onready var Bullet : Bala = get_parent()  #variavel exclusiva do método

#endregion

#region Methods

#método que ira rodar no inicio do game
func _ready() -> void:
	
	#conecto o sinal ao método
	VM.Conected_Signals(Bullet.Anim.animation_finished, Animacao_finalizada)

################################################################################

#endregion

#region My Methods

#método que rodara quando a animação da bala for finalizada
func Animacao_finalizada(_Anim_Name : StringName):
	
	#SE o nome da animação for igual a "start", eu...
	if _Anim_Name == "start":
		
		#dando o impulso
		Bullet.Vel += lerp(Bullet.Vel, (Bullet.Vel * ACRESIMO), SUAVIZACAO)

################################################################################

#endregion
