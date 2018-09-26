import hechizos.*
import fuerzaOscura.*
import artefactos.*
import refuerzos.*

class Personaje {

	var property nivelBase = 3
	var property habilidadLuchaBase = 1
	var property hechizoPreferido 
	var property dinero = 100
	
	var artefactos = #{}
	var puntajePorArtefactos = {_persona => _persona.artefactos().map( { _artefacto => _artefacto.unidadesDeLucha(_persona) }).sum()}
	
	// Punto 1
	
	method cambiarNombrePreferido(_nuevoNombre){
		hechizoPreferido.nombre(_nuevoNombre)  
	}
	method nivelHechiceria(){
		return nivelBase * hechizoPreferido.poder() + fuerzaOscura.valor()
	}
	method cambiarHechizoPreferido(_nuevoHechizo){
		hechizoPreferido = _nuevoHechizo 
	}
	method poderoso() = hechizoPreferido.poderoso()
	
	// Punto 2
	method agregarArtefacto(_artefacto){
		artefactos.add(_artefacto)
	}
	method quitarArtefacto(_artefacto){
		artefactos.remove(_artefacto)
	}
	method limpiarArtefactos(){
		artefactos.clear()
	}
	method artefactos() = artefactos
	method habilidadLucha() {
		return (habilidadLuchaBase + puntajePorArtefactos.apply(self))
	}
	method mayorHabilidadLuchaQueHechiceria(){
		return self.habilidadLucha() > self.nivelHechiceria()
	}

	// Punto 3
	method unicoArtefacto(_artefacto){
		return (artefactos.contains(_artefacto) && artefactos.size() == 1)
	}
	method artefactoMasPoderoso(){
		return artefactos.filter({artefacto => !artefacto.equals(espejoFantastico)}).max({ artefacto => artefacto.unidadesDeLucha(self)})
	}
	method estaCargado() {
		return (artefactos.size() >= 5)
	}
	
	//Punto 4
	method comprar (_objeto){
		_objeto.puedeComprar(self)
	}
	
	method pagar(_costo){
		dinero -= _costo
	}	
}

