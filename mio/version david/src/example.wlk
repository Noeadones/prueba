
object rolando {
	
	var property nivelHechiceria
	var property nivelLucha = 1
	var property nivelPoder = 0
	var property preferido = espectroMalefico
	var property valorFuerzaOscura = fuerzaOscura
	var property artefactos = #{}
	
 	method calcularNivelHechizos() {
		nivelHechiceria = (3 * preferido.valorPoder()) + valorFuerzaOscura.valorFuerza()
	}
	method cambiarPreferido(_nombre) {
		preferido.nombrePreferido(_nombre)
		preferido.cantidadPoder()
	}
	method cambiarPrefPorBasico (){
		preferido = hechizoBasico
	}
	method cambiarPrefPorLibroHechizos(){
		preferido = libroDeHechizos
		preferido.cantidadPoder()
	}
	method seSientePoderoso () = preferido.esPoderoso()
	method calcularNivelLucha() {
		nivelPoder = nivelPoder + artefactos.sum{artefacto => artefacto.poderLucha()}
		nivelLucha = nivelLucha + artefactos.sum{ artefacto => artefacto.puntosLucha()} + nivelPoder
	}
	method agregarArtefactos (_artefacto) {
		_artefacto.hechicero(self)
		artefactos.add(_artefacto)
	}
	method removerArtefactos (_artefacto){
		artefactos.remove(_artefacto)
	}
	method mayorLuchaQueHechiceria () = nivelLucha > nivelHechiceria
	method estaCargado () = artefactos.size() >= 5
}



object espectroMalefico {
	
	var property nombrePreferido = "Espectro malefico"
	var property valorPoder = nombrePreferido.size()
	
	method cantidadPoder () {
		valorPoder  = nombrePreferido.size()
	}
	method esPoderoso () = nombrePreferido.size() > 15
}

object hechizoBasico {
	
	const property valorPoder = 10
	
	method esPoderoso () = !(true)
}

object fuerzaOscura {
	
	var  property valorFuerza = 5
	
	method duplicar () {
		valorFuerza *= 2
	} 
}

object suceso {
	
	var property fuerzaO = fuerzaOscura
	
	method eclipse () = fuerzaO.duplicar()
}

object espadaDelDestino {
	var property hechicero = rolando
	method poderLucha () = 0
	method puntosLucha () = 3
}

object collarDivino {
	var property cantidadDePerlas =0
	var property hechicero = rolando
	method poderLucha () = 0
	method puntosLucha () = cantidadDePerlas 
}

object mascaraOscura {
	var property valorFuerzaOscura = fuerzaOscura
	var property hechicero = rolando
	
	method poderLucha () = 0
	method puntosLucha() = if (valorFuerzaOscura.valorFuerza() <= 5) 4 else valorFuerzaOscura.valorFuerza()/2
}

object armadura {
	var property hechicero = rolando
	var property nivelRefuerzo = 0
	
	method poderLucha () = if (hechicero.artefactos().contains(self)) (2 + nivelRefuerzo) else 0 
	method calcularRefuerzo (_refuerzo) {
		_refuerzo.asignarDuenio(hechicero)
		nivelRefuerzo = _refuerzo.poderRefuerzo()
	}
	method puntosLucha () = 0
}

object cota {
	var duenio
	method asignarDuenio (_duenio){
		duenio = _duenio
	}
	method poderRefuerzo() = 1
}

object bendicion {
	var duenio
	
	method asignarDuenio (_duenio){
		duenio = _duenio
	}
	method poderRefuerzo(){
		duenio.calcularNivelHechizos()
		return duenio.nivelHechiceria()
	}	
}

object hechizo {
	var duenio
	method asignarDuenio (_duenio){
		duenio = _duenio
	} 
	method poderRefuerzo () = duenio.preferido().valorPoder()
}

object espejo {
	var property hechicero = rolando
	
	method poderLucha () = hechicero.artefactos().map{ artefacto => artefacto.puntosLucha()}.max()
	method puntosLucha () = 0
}

object libroDeHechizos {
	var property valorPoder
	const property hechizos = #{}
	
	method agregarHechizos (_hechizo){
		hechizos.add(_hechizo)
	}
	
	method cantidadPoder() {
		valorPoder = hechizos.filter{hechizo => hechizo.esPoderoso()}.sum{hechizo => hechizo.valorPoder()}
	}
}