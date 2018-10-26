class Vagon {
	method pesoMaximo() = {}
	
	method esLiviano() = self.pesoMaximo() < 2500
}

class VagonDePasajeros inherits Vagon{
	var largo = 0
	var anchoUtil= 0
	
	method pasajerosQuePuedeTransportar() = if (anchoUtil < 2.5) largo * 8 
	                                        else largo * 10
		
	override method pesoMaximo()= self.pasajerosQuePuedeTransportar() * 80
	
	method cantidadDeBanios(){
		return self.pasajerosQuePuedeTransportar() / 50
	}
}

class VagonDeCarga inherits Vagon {
	var cargaMaxima = 0
	
	//metodos polimorficos
	method pasajerosQuePuedeTransportar() = 0
	method cantidadDeBanios() = 0
	
	override method pesoMaximo() = cargaMaxima + 160
	
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
	var locomotoras = []
	
	//6
	method vagonMasPesado(tren) = tren.vagones().max({vagon => vagon.pesoMaximo()})
	
	method vagonesMasPesados() = formaciones.map({tren => self.vagonMasPesado(tren)}).asSet()
    
    //7
    //no delegué nada :/
    //podria haber hecho un par de metodos para que no quede tan engorroso la lectura de este mismo 
    method conductorExperimentado(tren) =  (tren.vagones().size() + tren.locomotoras().size()) > 20 and 
                                     (tren.pesoDeLocomotoras() + tren.pesoDeVagones()) > 10000

    //8
    
  method guardarFormacion(formacion){
		formaciones.add(formacion)
	}
	
	method hayLocomotoraUtil() = locomotoras.filter{locomotora => locomotora.sirveParaMoverse()}
	
    
    
	method agregarLocomotoraAFormacion(formacion){
		if(not formacion.puedeMoverse() and not self.hayLocomotoraUtil().isEmpty()){
			self.guardarFormacion(self.hayLocomotoraUtil().first())
		}
	}
	
    
}

//parteDos

class CortaDistancia inherits Tren {
	
	var property esCompleja = true
	
	override method estaBienArmada() {
		return self.puedeMoverse() and not self.esCompleja()

	}
	
	override method velocidadMaxima()=60
	
}

class LargaDistancia inherits Tren {
	
	var destino = "gran ciudad"
	
	method agregrarBanio() {
		
	}	
	
	override method estaBienArmada() {
		return self.puedeMoverse()
			}
			
		override method velocidadMaxima(){
		var velocidadMaxima
		if(destino == "gran ciodad"){
			velocidadMaxima =200
		} else {
			velocidadMaxima = 150
		}
		return velocidadMaxima
	}		
}

class FormacionDeAltaVelocidad inherits LargaDistancia{
	
	method todoslosVagonesLivianos(){
		return vagones.all{vagon=> vagon.esLiviano()}
	}
	
	override method estaBienArmada() {
		return super() and self.todoslosVagonesLivianos() and self.velocidadMaxima() >250
	}
	

}










