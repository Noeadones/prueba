import rolando.*
import hechizos.*
import fuerzaOscura.*
import artefactos.*



class CotaDeMalla {
	var property bonus = 1
	method bonus(_) = bonus
	method valor(_) = bonus/2
}

object bendicion {
	
	method bonus(_persona) = _persona.nivelHechiceria()
	method valor(_persona) = _persona.valorBase()
}

class Hechizo {
	
	var property hechizo = hechizoBasico
	
	method bonus(_) = hechizo.poder()
	method valor(_persona) = _persona.valorBase() + hechizo.poder()
}