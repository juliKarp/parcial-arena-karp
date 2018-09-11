package unsam.algo3.parcial.runnable

import org.uqbar.arena.Application
import unsam.algo3.contactos.bootstrap.Bootstrap
import unsam.algo3.parcial.view.MainMenu
import unsam.algo3.parcial.model.MainMenuModel

class ContactosApplication extends Application {

	new() {
		super()
	}
	
	def static main(String[] args) {
		new ContactosApplication().start
	}
	override protected createMainWindow() {
		new MainMenu(this, new MainMenuModel(Bootstrap.agenda))
	}
}