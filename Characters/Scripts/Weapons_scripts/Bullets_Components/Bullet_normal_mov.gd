extends Node

#criando uma classe para ser usado como node
class_name MovBullet #movendo bala

#region Variables

#referenic ao node pai
@onready var Bullet : Bala = get_parent()  #variavel exclusiva do método

#endregion

#region Methods

#método que rodara a cada frame do game
func _process(_delta: float) -> void:
	
	#movendo o inimigo
	Bullet.position += Bullet.transform.x * Bullet.Vel

################################################################################

#endregion
