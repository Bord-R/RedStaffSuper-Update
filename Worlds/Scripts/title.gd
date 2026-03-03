extends Sprite2D

#region Variables

#valor maximo de rotação
const MAX_ROTATE : float = 0.25

#tempos do meu tween
var Times : Dictionary = {"Curto" : 0.25, "Médio" : 0.5}

#tween
var TweenSen : Tween = null

#endregion

#region Methods

#método que rodara quando eu estiver preparado
func _ready():
    
    if TweenSen: TweenSen.kill() #SE esse tween existe, eu deleto ele

    #definindo meu tween
    TweenSen = create_tween().bind_node(self).set_loops(-1)

    #interpolando minha posição y e rotação
    TweenSen.tween_property(self, "rotation", MAX_ROTATE, Times["Curto"]) 
    TweenSen.tween_method(SinPosY, 0, TAU, Times["Médio"]) 
    TweenSen.tween_property(self, "rotation", -MAX_ROTATE, Times["Curto"])  
    TweenSen.tween_method(SinPosY, 0, TAU, Times["Médio"]) 
    
################################################################################

#endregion

#region My Methods

#Método que mudara minha posição y com base na função seno
func SinPosY(_angle): # /angulo/
    position.y += sin(_angle) #minha posição y é somada ao seno de _angle

################################################################################

#endregion