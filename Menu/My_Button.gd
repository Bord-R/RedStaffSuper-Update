extends TextureButton

#criando classe para ser usado como node
class_name MyButton #kkkkkkkkkkkk

#region Variables

#valor 
const VALUE : float = 0.15

#minha escala original 
var Origin_Scale : Vector2 = Vector2(1.0, 1.0)

#minha escala modificada
var Modif_Scale : Vector2 = Vector2(1.1, 0.8)

#endregion

#region Methods

#método que rodara no inicio do game
func _ready() -> void:
	
	#chamando a função Entered mouse quando o sinal for ativado
	mouse_entered.connect(Entered_Mouse)
	
	#chamando a função Active Mouse quando o sinal for ativado
	pressed.connect(Active_Mouse) 

################################################################################

#método que rodara a cada frame do jogo
func _process(_delta: float) -> void:
	
	#SE minha escala não for igual a Origin Scale, eu executo o código
	if scale != Origin_Scale:
		
		#minha escala vai voltar a ser igual a Origin Scale
		scale = lerp(scale, Origin_Scale, VALUE)

################################################################################

#endregion

#region My Methods

#método que rodara quando o mouse encostar em mim
func Entered_Mouse():
	
	#espero 0.15 segundos, depois disso...
	await get_tree().create_timer(0.15).timeout
	
	#mudo minha escala
	scale = Modif_Scale * 0.9

################################################################################

#método que rodara quando eu for pressionado
func Active_Mouse():
	
	#mudo minha escala
	scale = Modif_Scale

################################################################################

#endregion 
