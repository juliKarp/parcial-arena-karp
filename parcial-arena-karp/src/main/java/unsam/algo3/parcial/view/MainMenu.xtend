package unsam.algo3.parcial.view

import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.GroupPanel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Window
import org.uqbar.arena.windows.WindowOwner
import unsam.algo3.contactos.domain.Contacto
import unsam.algo3.parcial.model.MainMenuModel

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.bindings.NotNullObservable

class MainMenu extends Window<MainMenuModel> {

	new(WindowOwner owner, MainMenuModel model) {
		super(owner, model)
		this.title = "Contactos"
	}

	override createContents(Panel mainPanel) {
		agregarBuscador(mainPanel)
		new Panel(mainPanel) => [
			layout = new HorizontalLayout
			agregarPanelContactos
			agregarPanelCreacion
		]
	}

	def void agregarBuscador(Panel panel) {
		new Panel(panel) => [
			layout = new HorizontalLayout
			new TextBox(it) => [
				value <=> "busquedaIngresada"
				width = 250
			]
			new Button(it) => [
				caption = "Buscar"
				onClick[this.modelObject.buscar]
			]
		]
	}

	def void agregarPanelContactos(Panel panel) {
		new Panel(panel) => [
			layout = new VerticalLayout
			new Table<Contacto>(it, typeof(Contacto)) => [
				items <=> "contactos"
				value <=> "contactoSeleccionado"
				numberVisibleRows = 10

				new Column<Contacto>(it) => [
					title = "Nombre y apellido"
					bindContentsToProperty("nombreApellido")
					fixedSize = 200
				]

				new Column<Contacto>(it) => [
					title = "Favorito"
					bindContentsToProperty("favorito").transformer = [if (it) { "Si"} else { "No"}]
					fixedSize = 100
				]
			]
			agregarAccionesContactos

		]
	}

	def void agregarAccionesContactos(Panel panel) {
		new Panel(panel) => [
			layout = new HorizontalLayout
			new Button(it) => [
				caption = "Favorito"
				bindEnabled(new NotNullObservable("contactoSeleccionado"))
				onClick[this.modelObject.favorito]
			]
			new Button(it) => [
				caption = "Editar"
				bindEnabled(new NotNullObservable("contactoSeleccionado"))
				onClick[new EditarContactoMenu(this, this.modelObject.contactoSeleccionado).open]
			]
		]
	}

	def void agregarPanelCreacion(Panel panel) {
		new GroupPanel(panel) => [
			title = "Nuevo Contacto"
			layout = new VerticalLayout
			agregarNombreValor("Nombre y Apellido:", "nuevoContacto.nombreApellido")
			agregarNombreValor("Teléfono:", "nuevoContacto.telefono")
			agregarNombreValor("email:", "nuevoContacto.email")
			new Button(it) => [
				caption = "Agregar"
				enabled <=> "nuevoContacto.validar"
				onClick[this.modelObject.crearUsuario]
			]
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
