extends Node2D

#angulo somado
@export var rot_summed : float = 0.0

#método que rodara a cada frame
func _process(_delta):

	#para i chegar ao alcance de todos os meus filhos
	for i in range(get_children().size()):

		#pegue meu filho de indice i e some a rotação dele a essa expressão ai
		get_child(i).rotation += rot_summed * _delta

################################################################################
