object fuerzaOscura {
	
	var property valor = 5
	var eclipse = false
	
	method eclipse() {
		if(!eclipse){ 
			valor *= 2
			eclipse = true
		}
	}

}