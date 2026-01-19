extends Node

class_name FreezeSuper

#region Variables

@onready var Bullet : Bala = get_parent()

#escala de tempo
@export_range(0, 1, 0.1) var Escala_time : float = 0.0

#duração
@export_range(0, 1, 0.05) var Duracao : float = 0.1

#endregion

#region Methods

#método que roda quando eu sou iniciado
func _ready() -> void:

	#conecto o sinal ao método
	VM.Conected_Signals(Bullet.area_entered, Area_Detectada)

	#congelo uns frames
	Game.Freeze_Frame(Escala_time, Duracao)

################################################################################

#endregion

#region My Methods

#método que sera ativado quando o sinal area entered for emitido
func Area_Detectada(_area : Area2D):
	
	#SE o pai da area for um enemiesfruits
	if _area.get_parent() is EnemiesFruits:

		#eu congelo uns frames
		Game.Freeze_Frame(Escala_time, Duracao)

################################################################################

#endregion