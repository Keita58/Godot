shader_type canvas_item;

void fragment() {
	// Called for every pixel the material is visible on.
	COLOR = texture(TEXTURE, UV); // Read from texture again.
	//Mix fa una interpolació linear entre x y utilitzant a.
	COLOR.r=mix(COLOR.r, 0.5, sin(TIME));
	COLOR.g=mix(COLOR.g, 0.8, sin(TIME+2.0));
	COLOR.b=mix(COLOR.b, 0.9, sin(TIME+5.0));
}
