import rolando.*
import hechizos.*
import fuerzaOscura.*
import artefactos.*



class CotaDeMalla {
	var property bonus = 1
	method bonus(_) = bonus
	method valor(_) = bonus/2
	method peso ()=1
}

object bendicion {
	
	method bonus(_persona) = _persona.nivelHechiceria()
	method valor(_artefacto) = _artefacto.valorBase()
	method peso() = 0
}

class Hechizo {
	
	var property hechizo = hechizoBasico
	
	method bonus(_) = hechizo.poder()
	method valor(_artefacto) = _artefacto.valorBase() + hechizo.poder()
	method peso() {
		if(hechizo.poder().even())
			return 2
		else
			return 1
		}
}