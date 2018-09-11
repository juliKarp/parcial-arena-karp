package unsam.algo3.parcial.view

import org.uqbar.arena.aop.windows.TransactionalDialog
import unsam.algo3.contactos.domain.Contacto
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.TextBox

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class EditarContactoMenu extends TransactionalDialog<Contacto> {

	new(WindowOwner owner, Contacto model) {
		super(owner, model)
		this.title = "Editar Contacto"
	}

	override createFormPanel(Panel mainPanel) {
		new Panel(mainPanel) => [
			agregarNombreValor("Nombre y Apellido:", "nombreApellido")
			agregarNombreValor("Teléfono:", "telefono")
			agregarNombreValor("email:", "email")
		]
	}

	override addActions(Panel actions) {
		new Button(actions) => [
			caption = "Aceptar"
			enabled <=> "validar"
			onClick [this.accept]
		]
	}

	def void agregarNombreValor(Panel panel, String nombre, String valor) {
		var valorPanel = new Panel(panel)
		valorPanel.layout = new VerticalLayout
		new Label(valorPanel) => [
			text = nombre
			width = 100
			alignLeft
		]
		new TextBox(valorPanel) => [
			value <=> valor
			width = 200
			alignLeft
		]
	}

}
