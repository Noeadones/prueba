import rolando.*
import fuerzaOscura.*
import artefactos.*
import refuerzos.*

class UserException inherits Exception { }

class Hechizos {
	
	method precio()
	method poder()
	method costo(_)
	method puedeComprar(_persona){
		if (_persona.dinero()>self.costo(_persona)){
			_persona.pagar(self.costo(_persona))
			_persona.hechizoPreferido(self)
		}
		else {
			 throw new UserException("No hay dinero suficiente")
			
		}
	}
	
}

class Logos inherits Hechizos{
	
	var property nombre 
	var multiplicador
	override method precio () = self.poder()
	override method costo (_persona) = (self.precio() - _persona.hechizoPreferido().poder()/2).max(0)
	
	override method poder() = nombre.length()*multiplicador
	method poderoso() = self.poder() > 15
	
	
}

object hechizoBasico inherits Hechizos {
	
	var poder = 10
	override method precio() = 10
	override method costo(_persona) = (self.precio() - _persona.hechizoPreferido().poder()/2).max(0)
	override method poder() = poder
	method poderoso() = false
	
}

// Punto 3

class LibroDeHechizos inherits Hechizos {
	
	var hechizos = #{}
	
	override method precio() = 10*hechizos.size() + self.poder()
	
	override method costo (_persona) = (self.precio() - _persona.hechizoPreferido().poder()/2).max(0)
	method escribirHechizo(_hechizo) {
		hechizos.add(_hechizo)
	}
	method hechizosPoderosos(){
		return hechizos.filter({ hechizo => hechizo.poderoso()})
	}
	override method poder(){
		return self.hechizosPoderosos().sum({hechizo => hechizo.poder()})
	}
	
}