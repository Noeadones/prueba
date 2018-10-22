import hechizos.*
import fuerzaOscura.*
import artefactos.*
import refuerzos.*

class UserException inherits Exception { }
class UserExceptionNoHayDinero inherits Exception{}
class UserExceptionNoSoportaPeso inherits Exception {}
class UserExceptionNoTieneObjeto inherits Exception {}

class Personaje {

	var property nivelBase = 3
	var property habilidadLuchaBase = 1
	var property hechizoPreferido = 0
	var property dinero = 100
	var property pesoMaximo = 100
	var property peso = 0
	
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
		peso += _artefacto.peso()
	}
	method quitarArtefacto(_artefacto){
		artefactos.remove(_artefacto)
		peso -= _artefacto.peso()
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
	method comprar (_objeto,_vendedor){
		if (self.puedeComprar(_objeto, _vendedor) && self.puedeSoportar(_objeto) && _vendedor.loTiene(_objeto) ){
			_vendedor.cobrar(self, _objeto)
			self.agregarArtefacto(_objeto)		
		}
		else if (!(self.puedeComprar(_objeto ,_vendedor))){
			 throw new UserExceptionNoHayDinero("No hay dinero suficiente")
			}
			else if (!(self.puedeSoportar(_objeto))){
				throw new UserExceptionNoSoportaPeso("No se puede soportar el peso del artefacto")
				}
				else if (!(_vendedor.loTiene(_objeto)))
				 throw new UserExceptionNoTieneObjeto("El comerciante no tiene el Objeto")
	}
	
	method canjear (_hechizo, _vendedor){
		if (self.puedeCanjear(_hechizo, _vendedor)&& (_vendedor.loTiene(_hechizo))){
			_vendedor.canjear(self, _hechizo)
			hechizoPreferido = _hechizo
		}
		else if (!(self.puedeComprar(_hechizo ,_vendedor)))
			throw new UserExceptionNoHayDinero("No hay dinero suficiente")
			
			else if (!(_vendedor.loTiene(_hechizo)))
				 throw new UserExceptionNoTieneObjeto("El comerciante no tiene el Objeto")		
	}
	method pagar(_monto){ dinero -= _monto }
	method puedeComprar(_artefacto, _vendedor) = (dinero > _vendedor.costoArtefacto(_artefacto)) 
	method puedeSoportar(_objeto) = pesoMaximo > (_objeto.peso() + peso)
	method puedeCanjear(_hechizo, _vendedor) = (dinero > _vendedor.costoHechizo(self, _hechizo))  
}

class NPC inherits Personaje {
	var property nivel 
	override method habilidadLucha() = super() * nivel.multiplicador()
}

object facil{ const property multiplicador = 1 }
object moderado{ const property multiplicador = 2 }
object dificil{ const property multiplicador = 4 }


class Comerciante {
	
	var property condicionImpositiva 
	const property artefactosEnVenta = []
	const property hechizosEnVenta = []
	var property oro = 0
	
	method impuesto (_artefacto) = condicionImpositiva.comision(_artefacto) 
	method costoArtefacto(_artefacto) = _artefacto.precio() + self.impuesto(_artefacto)
	method cobrar (_persona, _artefacto) {
		oro += self.costoArtefacto(_artefacto)
		_persona.pagar(self.costoArtefacto(_artefacto))
		self.quitarArtefacto(_artefacto)
	}
	method costoHechizo (_persona, _hechizo) = (_hechizo.precio() - _persona.hechizoPreferido().precio()/2).max(0)
	method canjear (_persona, _hechizo){
		oro += self.costoHechizo(_persona, _hechizo)
		_persona.pagar(self.costoHechizo(_persona, _hechizo))
		self.agregarHechizo(_persona.hechizoPreferido())		
		self.quitarHechizo(_hechizo)
	}
	method agregarArtefacto (_artefacto){ artefactosEnVenta.add(_artefacto)}
	method agregarHechizo (_hechizo){hechizosEnVenta.add(_hechizo)}
	method quitarArtefacto (_artefacto){ artefactosEnVenta.remove(_artefacto)}
	method quitarHechizo (_hechizo){hechizosEnVenta.remove(_hechizo)}
	method loTiene(_objeto) = artefactosEnVenta.contains(_objeto) || hechizosEnVenta.contains(_objeto)
	method recategorizar(){
		if(condicionImpositiva.estaRegistrado()){
			condicionImpositiva = impuestoALasGanancias
		}
		else if(condicionImpositiva.esIndependiente() && condicionImpositiva.duplicar() > 21)
			{
			condicionImpositiva = registrado
			}
		else if (condicionImpositiva.esIndependiente() && condicionImpositiva.duplicar() < 21){
			condicionImpositiva.porcentaje(condicionImpositiva.duplicar())
			}
			else if (condicionImpositiva.esImpuestoAlasGanancias()){}
	}
}


class CondicionImpositiva {
	var property minimoNoImponible 
	var property porcentaje = 0
	method esIndependiente () = false
	method estaRegistrado () = false
	method esImpuestoAlasGanancias () = false
 	method comision (_objeto) = _objeto.precio()*(porcentaje/100)
}
object independiente inherits CondicionImpositiva{ 
	override method esIndependiente() = true
	method duplicar() = porcentaje * 2
}

object registrado inherits CondicionImpositiva(porcentaje = 21) {
	override method estaRegistrado() = true
}

object impuestoALasGanancias inherits CondicionImpositiva(porcentaje = 35) {
	override method esImpuestoAlasGanancias() = true
	override method comision (_objeto){
		if (_objeto.precio() < minimoNoImponible)
			return 0
		else
			return (_objeto.precio() - minimoNoImponible)*(porcentaje/100)
	}
}