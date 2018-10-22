import rolando.*
import fuerzaOscura.*
import artefactos.*
import refuerzos.*

class UserException inherits Exception { }

class Hechizos {
	var property nombre 
	var multiplicador
	
	const property fechaDeCompra = fechaActual.hoy()
	method peso(_) = 0
	
	method poder() = nombre.length()*multiplicador
	method precio () = self.poder()
	method poderoso() = self.poder() > 15
}

class Logos inherits Hechizos{
	
}

object hechizoBasico inherits Hechizos {
	
	override method poder() = 10
	override method poderoso() = false
	
}

// Punto 3

class LibroDeHechizos inherits Hechizos {
	
	var hechizos = #{}
	
	method escribirHechizo(_hechizo) {
		hechizos.add(_hechizo)
	}
	method hechizosPoderosos(){
		return hechizos.filter({ hechizo => hechizo.poderoso()})
	}
	override method poder(){
		return self.hechizosPoderosos().sum({hechizo => hechizo.poder()})
	}
	override method precio() = 10*hechizos.size() + self.poder()
}

class HechizoComercial inherits Hechizos {
	var porcentaje = 0.2
	override method poder() = super() * porcentaje
	
}