extends CanvasLayer

#region Variables

#meu fundo
@export var BackGroud : TextureRect

#valor a ser subtraido ou somado
const MINOS : float = 0.005

#valor maximo para a interpolação
const MAX_VALUE : float = 1.0

#valor minimo para a interpolação
const MIN_VALUE : float = 0.25

#boleano que vereficara minha interpolação
var Bool_interpol : bool = true

#valor que sera interpolado
var Interpolation : float = 0.0

#endregion

#region Methods

#método que rodara a cada frame do game
func _process(_delta: float) -> void:
	
	#usando método para mudar a cor do back groud
	BackGroud_Variant()

################################################################################

#endregion

#region My Methods

#método que rodara a mudança de cor do backgroud
func BackGroud_Variant():
	
	#SE a interpol KKKKK for verdadeira, eu executo o código
	if Bool_interpol:
		
		#diminuindo o valor da interpolação
		Interpolation -= MINOS
		
		#SE a interpolação for menor ou maior que o valor minimo, eu...
		if Interpolation <= MIN_VALUE:
			
			#a interpol é falsa
			Bool_interpol = false
	
	#SE NÃO, SE a interpol for falsa, eu executo o código
	if !Bool_interpol:
		
		#minha interpolação é aumentada
		Interpolation += MINOS
		
		#SE a interpolação for maior ou igual a que o valor maximo, eu...
		if Interpolation >= MAX_VALUE:
			
			#a interpol é verdadeira
			Bool_interpol = true
	
	#mudando o valor de uma variavel de um shader de um node filho
	BackGroud.material.set("shader_parameter/Varicao", Interpolation) #mudando a luminosidade do backgroud

################################################################################

#endregion
