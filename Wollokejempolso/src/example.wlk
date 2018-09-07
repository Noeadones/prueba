/**ROLANDO */
object rolando {
	var nivel = 3
	var hechizoPreferido = hechizoBasico
	method nivelHechizeria() {
		nivel = 3 * hechizoPreferido.poder() + fuerzaOscura.valor()
	}
	
	method hechizoPreferido(_hechizoPreferido){
		hechizoPreferido = _hechizoPreferido
	}
}

object hechizoBasico {
	method poder () = 10
	method poderoso () = false
	
}

object espectroMalefico {
	method poder ()= 2
	
}

object fuerzaOscura{
	method valor() = 5
}