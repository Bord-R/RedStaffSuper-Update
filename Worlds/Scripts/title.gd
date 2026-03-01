extends Sprite2D

#region Variables

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
    TweenSen.tween_property(self, "rotation", 0.25, 0.25) 
    TweenSen.tween_method(SinPosY, 0, TAU, 0.5) 
    TweenSen.tween_property(self, "rotation", -0.25, 0.25)  
    TweenSen.tween_method(SinPosY, 0, TAU, 0.5) 
    
################################################################################

#endregion

#region My Methods

#Método que mudara minha posição y com base na função seno
func SinPosY(_angle): # /angulo/
    position.y += sin(_angle) #minha posição y é somada ao seno de _angle

################################################################################

#endregion