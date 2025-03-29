shader_type canvas_item;

//Utiliza la función de vértice para calcular en qué parte de la pantalla debe terminar cada vértice.
void vertex() {
	// Called for every vertex the material is visible on.
	//VERTEX -= vec2(cos(TIME)*100.0, sin(TIME)*100.0);
}

void fragment() {
	// Called for every pixel the material is visible on.
	COLOR = texture(TEXTURE, UV); // Read from texture again.
	//Mix fa una interpolació linear entre x y utilitzant a.
	COLOR.r=mix(COLOR.r, 0.5, (sin(TIME)+1.0)*1.0);
	COLOR.g=mix(COLOR.g, 0.8, (sin(TIME+2.0) +1.0)*1.0);
	COLOR.b=mix(COLOR.b, 0.9, (sin(TIME+5.0)+1.0)*1.0);
}
//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
