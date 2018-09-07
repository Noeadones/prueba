/**ROLANDO */
object rolando {
	var nivel = 3
	var hechizoPreferido
	method nivelHechizeria() {
		nivel = 3 * hechizoPreferido.poder() + fuerzaOscura
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