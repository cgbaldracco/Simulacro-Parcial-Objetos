class Vikingo  {
	var casta
	var rol
	var oro = 0
	
	constructor(perteneceA,clase) {
		casta=perteneceA
		rol=clase
	}
	
	method requisitoParaExpedicion() {
		if(!casta.puedeIrAUnaExpedicion()) {
			throw new Exception("No puede incorporarse a la expedicion porque es un soldado Jarl y no posee armas")
		}
		if(!rol.productivo()) {
			throw new Exception("No puede incorporarse a la expedicion porque no es un vikingo productivo")
		}
		return casta.puedeIrAUnaExpedicion() && rol.productivo()
	}
	
	method ascender() {
		casta = casta.ascender(rol)
	}
	
}

class Jarl {
    var armas
	constructor(darArmas) {
		armas=darArmas
	}
	
	method puedeIrAUnaExpedicion() {
		return armas!=[] 
	}
	
	method ascender(rol) {
		rol.ascender()
		return new Karl(armas+=10)
	}
}

class Karl {
	var armas
	constructor(darArmas) {
		armas=darArmas
	}
	
	method puedeIrAUnaExpedicion() {}
	
	method ascender(rol) {
		return new Tharl(armas)
	}
}

class Tharl {
	var armas
	constructor(darArmas) {
		armas=darArmas
	}
	
	method puedeIrAUnaExpedicion() {}
	
	method ascender(rol) = self
}

class Granjero {
	var hijos
	var hectareas
	
	constructor(cantHijos,cantHectareas){
		hijos=cantHijos
		hectareas=cantHectareas
	}
	
	method productivo() {
		return hijos <= hectareas/2
	}
	
	method ascender() {
		hijos += 2
		hectareas += 2
	}
}

class Soldado {
	var vidasCobradas
	var almasPoseidas
	
	constructor(cantVidas,almas) {
		vidasCobradas=cantVidas
		almasPoseidas=almas
	}
	
	method productivo() {
		return vidasCobradas >= 20 && almasPoseidas!=[]
	}
	
	method ascender() {}
}

class Expedicion {
	var destinos
	var integrantes = #{}
	
	constructor(lugaresDestino) {
		destinos=lugaresDestino
	}
	
	method subirVikingoALaExpedicion(vikingo) {
		if(vikingo.requisitoParaExpedicion()) {
			integrantes.add(vikingo)
		}
	}
	
	method salirDeExpedicion() {
		
	}
	
	method valeLaPena() {
		return destinos.forAll({destino => destino.valeLaPena(integrantes)})
	}
}

class Capital {
	var factorDeRiqueza
	var defensores
	
	constructor(potenciador,cantDefensores) {
		factorDeRiqueza=potenciador
		defensores=cantDefensores
	}
	
	method botin(integrantes) {
		return (integrantes.take(defensores)).size()*factorDeRiqueza
	}
	
	method valeLaPena(integrantes) {
		return self.botin(integrantes) >= integrantes.size()*3
	}
}

class Aldea {
	var iglesias
	
	constructor(iglesiasDeLaAldea) {
		iglesias=iglesiasDeLaAldea
	}

	method valeLaPena(integrantes) {
		return self.sedDeSaqueo(integrantes)
	}
	
	method sedDeSaqueo(integrantes) {
		return iglesias.sum({iglesia => iglesia.crucifijos()}) >= 15
	}
}

class Iglesia {
	var crucifijos
	
	constructor(cantCrucifijos) {
		crucifijos=cantCrucifijos
	}
	
	method crucifijos() {
		return crucifijos
	}
}

class Amuralladas inherits Aldea {
	var cantMinVikingos 
	
	constructor(minimo) = super(iglesiasDeLaAldea) {
		cantMinVikingos=minimo
	}
	
	override method sedDeSaqueo(integrantes) {
		return self.cumpleMinimo(integrantes) && super(integrantes)
	}
	
	method cumpleMinimo(integrantes) {
		return integrantes.size() >= cantMinVikingos
	}
}