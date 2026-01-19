shader_type canvas_item;

uniform vec4 flash_cor : source_color;

uniform float float_flash : hint_range(0.0, 1.0, 0.1);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	
	vec4 texture_cor = texture(TEXTURE,UV);
	
	COLOR = mix(texture_cor,flash_cor,float_flash);
	
	COLOR.a = texture_cor.a;
	
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}