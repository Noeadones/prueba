import fuerzaOscura.*
import hechizos.*
import refuerzos.*
import rolando.*
class UserException inherits Exception { }

class Artefacto {
	
	method costo(_)
	method unidadesDeLucha(_persona)
	method puedeComprar(_persona){
		if (_persona.dinero()>self.costo(_persona)){
			_persona.pagar(self.costo(_persona))
			_persona.agregarArtefacto(self)
		}
		else {
			 throw new UserException("No hay dinero suficiente")
		}
	}
}

class Arma inherits Artefacto {
	
	var unidadesDeLucha = 3
	override method costo (_) = unidadesDeLucha*5
	override method unidadesDeLucha(_persona) = unidadesDeLucha	 
}

class CollarDivino inherits Artefacto {
	
	var property perlas = 5
	override method costo(_) = 2*perlas
	override method unidadesDeLucha(_persona) = perlas
}

class MascaraOscura inherits Artefacto {
	var property valorMinimo = 4
	var indice
	
	constructor(_indice) {
		indice = _indice
	}
	
	override method costo(_) = 0
	override method unidadesDeLucha(_persona) {
		return valorMinimo.max((fuerzaOscura.valor()/2)*indice)
	}
}
// Punto 3
class Armadura inherits Artefacto{
	
	var unidadesDeLucha = 2
	var refuerzo
	var property valorBase = 2
	
	
	method agregarRefuerzo(_refuerzo) {
		refuerzo = _refuerzo
	}
	method eliminarRefuerzo() {
		refuerzo = null
	}		
	override method unidadesDeLucha(_persona) = unidadesDeLucha + self.diferenciaBonus(_persona)
	method diferenciaBonus(_persona){
		if (refuerzo != null){
			return refuerzo.bonus(_persona)
		}
		 else { 
		 	return 0
		 } 
	}
	override method costo (_) { 
		if (refuerzo != null){
			return refuerzo.valor(self) 
		}
		else {return valorBase }
	}
	
}

object espejoFantastico inherits Artefacto {
	
	const precio = 90
	override method costo(_) = precio
	override method unidadesDeLucha(_persona) {
		if(_persona.unicoArtefacto(self)) {
			return 0
		} else 
			{ return _persona.artefactoMasPoderoso().unidadesDeLucha(_persona) 
		}
	}
}
