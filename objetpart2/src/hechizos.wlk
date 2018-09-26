
class Logos {
	
	var nombre 
	var multiplicador
	method costo (_persona) { self.poder()
		if
	}
	
	
	
	method poder() = nombre.length()*multiplicador
	method poderoso() = self.poder() > 15
	method nombre(_nombre) {
		nombre = _nombre
	}
	
	method puedeComprar(_persona){
		if (_persona.dinero()>self.costo(_persona)){
			_persona.pagar(self.costo(_persona))
			_persona.hechizoPreferido(self)
		}
	}
}

object hechizoBasico {
	
	var poder = 10
	method costo(_) = 10
	method poder() = poder
	method poderoso() = false
	
	method puedeComprar(_persona){
		if (_persona.dinero()>self.costo(_persona)){
			_persona.pagar(self.costo(_persona))
			_persona.hechizoPreferido(self)
		}
	}
}

// Punto 3

class LibroDeHechizos {
	
	var hechizos = #{}
	
	method costo (_) = 2*hechizos.size() + hechizos.sum({hechizo => hechizo.poder()})
	method escribirHechizo(_hechizo) {
		hechizos.add(_hechizo)
	}
	method hechizosPoderosos(){
		return hechizos.filter({ hechizo => hechizo.poderoso()})
	}
	method poder(){
		return self.hechizosPoderosos().sum({hechizo => hechizo.poder()})
	}
	
	method puedeComprar(_persona){
		if (_persona.dinero()>self.costo(_persona)){
			_persona.pagar(self.costo(_persona))
			_persona.hechizoPreferido(self)
		}
	}
}