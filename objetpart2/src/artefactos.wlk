import fuerzaOscura.*
import hechizos.*
import refuerzos.*
import rolando.*
class UserException inherits Exception { }


object fechaActual{
	const property hoy = new Date()
}
class Artefacto {
	
	const property fechaDeCompra = fechaActual.hoy()
	var property pesoArtefacto = 0
	
	method peso() = pesoArtefacto - self.factorCorrecion() 
	method factorCorrecion() {
		if (self.dias() > 2500)
			return 1
		else
			return self.dias()/1000
	}
	method dias () = fechaActual.hoy() - fechaDeCompra

	method unidadesDeLucha(_persona)

}

class Arma inherits Artefacto {
	
	var unidadesDeLucha = 3

	override method unidadesDeLucha(_persona) = unidadesDeLucha
	method precio () = 5*pesoArtefacto	 
}

class CollarDivino inherits Artefacto {
	
	var property perlas = 5
	method precio() = 2*perlas
	override method unidadesDeLucha(_persona) = perlas
	override method peso() = super() + perlas/2
	
}

class MascaraOscura inherits Artefacto {
	var property valorMinimo = 4
	var property indice
	override method unidadesDeLucha(_persona) {
		return valorMinimo.max((fuerzaOscura.valor()/2)*indice)
	}	
	override method peso () {
		if (indice == 0) 
			return super()
		else 
			return super() + ((valorMinimo.max((fuerzaOscura.valor()/2)*indice))-3).max(0)
	}
	
	method precio () = 10 * indice
}
// Punto 3
class Armadura inherits Artefacto{
	
	var unidadesDeLucha = 2
	var property refuerzo 
	var property valorBase = 2
	
	override method unidadesDeLucha(_persona) = unidadesDeLucha + self.diferenciaBonus(_persona)
	method diferenciaBonus(_persona){
		if (refuerzo != null){
			return refuerzo.bonus(_persona)
		}
		 else {
		 	return 0
		 } 
	}
	method precio() { 
		if (refuerzo != null){
			return refuerzo.valor(self) 
		}
		else {return valorBase }
	}
	override method peso () {
		if (refuerzo!= null)
			return super() + refuerzo.peso()
		else {return super()}
	} 
}

object espejoFantastico inherits Artefacto {
	
	const property precio = 90
	override method unidadesDeLucha(_persona) {
		if(_persona.unicoArtefacto(self)) {
			return 0
		} else 
			{ return _persona.artefactoMasPoderoso().unidadesDeLucha(_persona) 
		}
	}
	override method peso() = 0
}
