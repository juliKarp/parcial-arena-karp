package unsam.algo3.parcial.model

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.utils.ObservableUtils
import unsam.algo3.contactos.domain.Agenda
import unsam.algo3.contactos.domain.Contacto
import org.apache.commons.lang.StringUtils

@Accessors
@Observable
class MainMenuModel {
	val Agenda agenda
	Contacto contactoSeleccionado
	Contacto nuevoContacto
	String busquedaIngresada
	String busquedaActual
	
	new (Agenda agenda) {
		this.agenda = agenda
		this.nuevoContacto = new Contacto
	}
	
	def getContactos(){
		if (StringUtils.isBlank(busquedaActual)) {
			agenda.contactos
		} else {
			agenda.contactos.filter[tieneValorBuscado(busquedaActual)].toList
		}
		
	}

	def crearUsuario() {
		agenda.agregarContacto(nuevoContacto)
		this.nuevoContacto = new Contacto
		ObservableUtils.firePropertyChanged(this, "contactos")
	}
	
	def favorito() {
		contactoSeleccionado.toggleFavorito
	}
	
	def buscar() {
		busquedaActual = busquedaIngresada
		ObservableUtils.firePropertyChanged(this, "contactos")
	}
	
}