package unsam.algo3.contactos.domain

import org.apache.commons.lang.StringUtils
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.TransactionalAndObservable

@Accessors
@TransactionalAndObservable
class Contacto {
	
	String nombreApellido
	String email
	String telefono
	Boolean favorito = false
	
	def toggleFavorito() {
		favorito = !favorito
	}
	
	@Dependencies("nombreApellido", "telefono", "email") 
	def getValidar() {
		if (StringUtils.isBlank(nombreApellido)){
			return false
		}
		if (StringUtils.isBlank(telefono)){
			return false
		}
		if (StringUtils.isBlank(email)){
			return false
		}
		return true
	}
	
	def tieneValorBuscado(String valorBusqueda) {
		if (StringUtils.containsIgnoreCase(nombreApellido, valorBusqueda)) {
			return true
		}
		if (StringUtils.containsIgnoreCase(email, valorBusqueda)) {
			return true
		}
		if (StringUtils.equalsIgnoreCase(telefono, valorBusqueda)) {
			return true
		}
		return false
	}
}