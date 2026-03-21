extends CanvasLayer

#region Variables

#region In Scene Elements

var shadow_vines_in_scene : Vector2 = Vector2(329.0, 143.0) #posição final das vinhas de trás

var vines_in_scene : Vector2 = Vector2(321.0, 159.0) #posição final das vinhas da frente

var bar_in_scene : Vector2 = Vector2(315.0, 167.0) #posição final da barra de opções

var text_in_scene : Vector2 = Vector2(145.0, 96.0) #posição final do texto de pause

var button_resume_in_scene : Vector2 = Vector2(390.0, 200.0) #posição final do botão de resume

#endregion

#region Out Scene Elements

var shadow_vines_out_scene : Vector2 = Vector2(329.0, -163.0) #posição inicial das vinhas de trás

var vines_out_scene : Vector2 = Vector2(321.0, -179.0) #posição inicial das vinhas da frente

var bar_out_scene : Vector2 = Vector2(900.0, 167.0) #posição inicial da barra de opções

var text_out_scene : Vector2 = Vector2(-226.0, 96.0) #posição inicial do texto de pause

var button_resume_out_scene : Vector2 = Vector2(390.0, 400.0) #posição inicial do botão de resume

#endregion

#region Backgroud

const ALPHA_IN_SCENE : float = 0.55 #alfa minimo do fundo da tela de pause

const ALPHA_OUT_SCENE : float = 1.0 #alfa máximo do fundo da tela de pause

#endregion

#region Elements

@export var ShadowVines : Sprite2D #vinhas de traz 
	
@export var Vines : Sprite2D #vinhas da frente

@export var BarPause : Sprite2D #barra onde fica as opções

@export var TextPause : Sprite2D #texto de pause

@export var ButtonResume : MyButton #botão de resume

@export var Background : TextureRect #fundo da tela de pause

#endregion

#boleano que verifica se o jogo pode ser pausado
var Can_Pause : bool = false

#tween que animara todos os meus filhos 
var tween_Pause : Tween = null

#dicionário que guarda os tempos de animação
var time_anim : Dictionary = {
	"min": 0.8, #tempo de animação minimo
	"mid": 1.2, #tempo de animação médio
	"max": 1.6 #tempo de animação máximo
}

#endregion

#region Methods

func _ready(): #função chamada quando a cena é carregada
	
	VM.Conected_Signals(ButtonResume.button_up, Press_Resume) #conecta o sinal de button_up do meu botão de resume com a função de Press_Resume

################################################################################

func _process(_delta: float) -> void:
	
	if Game.Player_Dead: return #SE o jogador estiver morto retorna

	if Input.is_key_label_pressed(KEY_ESCAPE) and Can_Pause: #SE a tecla de escape for pressionada E o jogo poder ser pausado

		Elements_in_Scene() #chama a função de Press_Resume

		get_tree().paused = true #pausa o jogo

		Can_Pause = false #o jogo não pode estar pausado

################################################################################

#endregion

#region My Methods

#função chamada quando o botão de resume é pressionado
func Press_Resume():

	Elements_out_Scene() #chama a função de animação de saída

################################################################################

#animacao de entrada
func Elements_in_Scene():

	visible = true #deixa a tela de pause visivel

	if tween_Pause:tween_Pause.kill() #mata o tween caso ele exista, para evitar bugs

	tween_Pause = create_tween().bind_node(self) #cria um tween

	tween_Pause.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_ELASTIC) #define a curva de animação

	Background.visible = true #deixa o fundo da tela de pause visivel
	
	#animação de entrada
	tween_Pause.parallel().tween_property(Background.material, "shader_parameter/Alpha_Cor", ALPHA_IN_SCENE, time_anim["min"])
	tween_Pause.parallel().tween_property(ShadowVines, "position", shadow_vines_in_scene, time_anim["min"])
	tween_Pause.parallel().tween_property(Vines, "position", vines_in_scene, time_anim["min"])
	tween_Pause.parallel().tween_property(BarPause, "position", bar_in_scene, time_anim["mid"])
	tween_Pause.parallel().tween_property(TextPause, "position", text_in_scene, time_anim["mid"])
	tween_Pause.parallel().tween_property(ButtonResume, "position", button_resume_in_scene, time_anim["max"])

################################################################################

#animação de saída
func Elements_out_Scene():

	if tween_Pause:tween_Pause.kill() #mata o tween caso ele exista, para evitar bugs

	tween_Pause = create_tween().bind_node(self) #cria um tween

	tween_Pause.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_ELASTIC) #define a curva de animação	

	#animação de saída
	tween_Pause.parallel().tween_property(Background.material, "shader_parameter/Alpha_Cor", ALPHA_OUT_SCENE, time_anim["max"])
	tween_Pause.parallel().tween_property(ShadowVines, "position", shadow_vines_out_scene, time_anim["min"])
	tween_Pause.parallel().tween_property(Vines, "position", vines_out_scene, time_anim["min"])
	tween_Pause.parallel().tween_property(BarPause, "position", bar_out_scene, time_anim["mid"])
	tween_Pause.parallel().tween_property(TextPause, "position", text_out_scene, time_anim["max"])
	tween_Pause.parallel().tween_property(ButtonResume, "position", button_resume_out_scene, time_anim["mid"])

	await tween_Pause.finished #espera a animação terminar

	Background.visible = false #deixa o fundo da tela de pause invisivel

	visible = false #deixa a tela de pause invisivel

	Can_Pause = true #o jogo pode ser pausado

	get_tree().paused = false #despausa o jogo

################################################################################

#endregion
