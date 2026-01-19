shader_type canvas_item;

uniform float Reducao;

uniform vec4 escuridao : source_color;

uniform float Varicao : hint_range(0.0, 1.0, 0.01);

void vertex() {

	UV.x += TIME * Reducao;
	UV.y -= TIME * Reducao;

	COLOR = escuridao;

}

void fragment(){
	
	vec4 _Texture = texture(TEXTURE, UV);
	
	
	COLOR = mix(_Texture, escuridao, Varicao);
	
	COLOR.a = Varicao;
	
}