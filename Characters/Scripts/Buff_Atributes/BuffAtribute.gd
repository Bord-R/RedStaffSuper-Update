extends Node2D

#classe base para todo novo BuffAtribute que for criado
class_name BuffAtribute

signal player_new_buff(_buff : BuffAtribute, _player : FruitsCharacter) #sinal que avisara que eu toquei no player

@export var anim_BA : AnimationPlayer #minhas animações

@export var hitbox_BA : Area2D #minha hitbox

@export var caught_anim : String #animação de quando for pego

#método que rodara quando eu for carregado
func _ready():

	VM.Conected_Signals(hitbox_BA.area_entered, On_HitBox)

################################################################################

func On_HitBox(_area): #método que rodara quando eu for tocado por algo
   
	if _area.name == "Player": #SE a area tiver o nome de Player

		player_new_buff.emit(self, _area.get_parent()) #emito que o player ganhou um novo buff

		anim_BA.play(caught_anim) #rodo a animação de quando sou pego

		_area.get_parent().Screen_shake.trigger_shake(10)

		await anim_BA.animation_finished #ESPERE até que a animação acabe

		queue_free() #me deleto

################################################################################
