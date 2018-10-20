class VagonDePasajeros {
	var largo = 0
	var anchoUtil= 0
	
	method pasajerosQuePuedeTransportar() = if (anchoUtil < 2.5) largo * 8 
	                                        else largo * 10
		
	method pesoMaximo()= self.pasajerosQuePuedeTransportar() * 80
}

class VagonDeCarga {
	var cargaMaxima = 0
	
	method pasajerosQuePuedeTransportar() = 0
	method pesoMaximo() = cargaMaxima + 160
	
}

class Locomotora {
	var property peso = 0
	var property maximoArrastre = 0
	var property velocidadMaxima = 0
	
	method arrastreUtil() = maximoArrastre - peso
	
	method pesoMaximo() = peso	
}

class Tren {
	//las property están porque necesito el get en el ejercicio 7
	var property vagones = []
	var property locomotoras = []
	
	method agregarVagon(unVagon) {
		vagones.add(unVagon)
	}
		
	
	//1
	method cantidadDeVagonesLivianos() = vagones.count({vagon=> vagon.pesoMaximo() < 2500})
	
	//2
	method mapeoDeVelocidadDeLocomotoras() = locomotoras.map({locomotora => locomotora.velocidadMaxima()})
		
	method velocidadMaxima() = self.mapeoDeVelocidadDeLocomotoras().min()	
	
	//3	
    method locomotoraEficiente(unaLocomotora) =  unaLocomotora.peso() <= unaLocomotora.arrastreUtil()
		
	method locomotorasEficientes() = locomotoras.all({locomotora => self.locomotoraEficiente(locomotora)})
    
     //4
    method arrastreDeLocomotoras() = locomotoras.sum({locomotora => locomotora.arrastreUtil()})
    
    method pesoDeVagones() = vagones.sum({vagon => vagon.pesoMaximo()})
    
    method puedeMoverse() = self.arrastreDeLocomotoras() >= self.pesoDeVagones()
    
    //5
    method kilosDeEmpujeFaltante() = self.pesoDeVagones() - self.arrastreDeLocomotoras()
    
    //metodo para el punto 7 en class deposito
    method pesoDeLocomotoras() = locomotoras.sum({locomotora => locomotora.peso()})
    
    //metodo abstracto
    method estaBienArmada() = {}
}

class Deposito {
	
	var formaciones = []
	
	//6
	method vagonMasPesado(tren) = tren.vagones().max({vagon => vagon.pesoMaximo()})
	
	method vagonesMasPesados() = formaciones.map({tren => self.vagonMasPesado(tren)}).asSet()
    
    //7
    //no delegué nada :/
    //podria haber hecho un par de metodos para que no quede tan engorroso la lectura de este mismo 
    method conductorExperimentado(tren) =  (tren.vagones().size() + tren.locomotoras().size()) > 20 and 
                                     (tren.pesoDeLocomotoras() + tren.pesoDeVagones()) > 10000

    //8
    
    method buscarLocomotora(unTren) {
    	return unTren.locomotoras()
    }
    
    method agregarALocomotora(unTren) {
    	if(! unTren.puedeMoverse()) {
    		
    	}
    }
    
    
}

//parteDos

class CortaDistancia inherits Tren {
	
	override method estaBienArmada() {
		return self.puedeMoverse()
		//que quiere decir con que no tiene que ser compleja???
	}
	
}

class LargaDistancia inherits Tren {
	
	method agregrarBanio() {
		
	}
	
	override method estaBienArmada() {
		return self.puedeMoverse()
			}
}









