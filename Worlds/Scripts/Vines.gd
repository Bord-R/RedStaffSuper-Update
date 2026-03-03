extends Node2D

#region Variables

#angulo somado
@export var rot_summed : float = 0.0

#variavel que ocilara entre 1 e -1
var Oscilation : int = 0

#endregion

#region Methods

#método que rodara a cada frame
func _process(_delta):

	#para i chegar ao alcance de todos os meus filhos
	for i in range(get_children().size()):

		#definindo minha ocilação entre menos um e um
		###EXPLICAÇÂO DO SISTEMA
		#SE i ao elevar -1 for par, Oscilation = 1
		#SE i ao elevar -1 for impar, Oscilation = -1
		# (**) = potência
		Oscilation = -1 ** i

		#pegue meu filho de indice i e some a rotação dele a essa expressão ai
		get_child(i).rotation += rot_summed * _delta * Oscilation

################################################################################

#endregion