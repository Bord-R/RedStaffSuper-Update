extends Node

#criando classe para ser usado como node
class_name CollidedWalls #colidindo com as paredes

#region Variables

#exportando para o inspetor
@export var FORCE_SHAKE : float = 1.0

@export var IsDeleteDaddy : bool = true #boleano que vera se eu posso deletar meu pai

#referencia ao node pai
@onready var Bullet : Bala = get_parent() #variavel exclusiva do método

#endregion

#region Method

#método que rodara no inicio do game
func _ready() -> void:

	#conecto o sinal ao método
	VM.Conected_Signals(Bullet.body_entered, Colidindo)

################################################################################

#endregion

#region My Method

#método que rodara quando o sinal for ativado
func Colidindo(_Corpo : Node2D):
	
	#SE o corpo for um tilemaplayer, eu...
	if _Corpo is TileMapLayer:
		
		#ativo o screen shake 
		Bullet.Screen_shake.trigger_shake(FORCE_SHAKE)
		
		#SE eu posso deletar meu pai, eu deleto ele
		if IsDeleteDaddy: Bullet.Effect_explodion()

################################################################################

#endregion
