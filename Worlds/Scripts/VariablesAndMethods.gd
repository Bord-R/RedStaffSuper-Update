extends Node

#region Variables

const MINOS_TIMER : float = 0.025

#endregion

#region Methods

#método que conectara sinais aos métodos
func Conected_Signals(_your_signal : Signal, _your_method : Callable): #parametros /seu sinal/ seu método/

	#SE o seu sinal já NÃO foi conectado a seu método
	if !_your_signal.is_connected(_your_method):

		#conecto o seu sinal ao seu método
		_your_signal.connect(_your_method)

################################################################################

#endregion
