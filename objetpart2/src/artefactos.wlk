import fuerzaOscura.*
import hechizos.*
import refuerzos.*
import rolando.*

class Arma {
	
	var unidadesDeLucha = 3
	method costo (_) = unidadesDeLucha*5
	method unidadesDeLucha(_persona) = unidadesDeLucha
	
 	method puedeComprar(_persona){
		if (_persona.dinero()>self.costo(_persona)){
			_persona.pagar(self.costo(_persona))
			_persona.agregarArtefacto(self)
		}
	}
	 
}

class CollarDivino {
	
	var property perlas = 5
	method costo(_) = 2*perlas
	method unidadesDeLucha(_persona) = perlas
	method puedeComprar(_persona){
		if (_persona.dinero()>self.costo(_persona)){
			_persona.pagar(self.costo(_persona))
			_persona.agregarArtefacto(self)
		}
	}
}

class MascaraOscura {
	var property valorMinimo = 4
	var indice
	
	constructor(_indice) {
		indice = _indice
	}
	
	method costo(_) = 0
	method unidadesDeLucha(_persona) {
		return valorMinimo.max((fuerzaOscura.valor()/2)*indice)
	}
		method puedeComprar(_persona){
		if (_persona.dinero()>self.costo(_persona)){
			_persona.pagar(self.costo(_persona))
			_persona.agregarArtefacto(self)
		}
	}
}
// Punto 3
class Armadura {
	
	var unidadesDeLucha = 2
	var refuerzo
	var valorBase = 2
	
	
	method agregarRefuerzo(_refuerzo) {
		refuerzo = _refuerzo
	}
	method eliminarRefuerzo() {
		refuerzo = null
	}		
	method unidadesDeLucha(_persona) = unidadesDeLucha + self.diferenciaBonus(_persona)
	
	method diferenciaBonus(_persona){
		if (refuerzo != null){
			return refuerzo.bonus(_persona)
		}
		 else { 
		 	return 0
		 } 
	}
	
	method costo (_) = if (refuerzo != null) refuerzo.valor(self) else valorBase
	
	method puedeComprar(_persona){
		if (_persona.dinero()>self.costo(_persona)){
			_persona.pagar(self.costo(_persona))
			_persona.agregarArtefacto(self)
		}
	}
	
	
}

object espejoFantastico {
	
	method costo(_) = 90
	method unidadesDeLucha(_persona) {
		if(_persona.unicoArtefacto(self)) {
			return 0
		} else 
			{ return _persona.artefactoMasPoderoso().unidadesDeLucha(_persona) 
		}
	}
		method puedeComprar(_persona){
		if (_persona.dinero()>self.costo(_persona)){
			_persona.pagar(self.costo(_persona))
			_persona.agregarArtefacto(self)
		}
	}
}
