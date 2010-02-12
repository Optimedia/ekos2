package br.com.optimedia.autor
{
	import br.com.optimedia.autor.assets.CommandConstants;
	import br.com.optimedia.autor.controller.AutorStartupCommand;
	import br.com.optimedia.autor.controller.ModelStartupCommand;
	
	import org.puremvc.as3.multicore.patterns.facade.Facade;

	public class AutorFacade extends Facade
	{
		
		public function AutorFacade(key:String)
		{
			super(key);
		}

		/**
         * Singleton ApplicationFacade Factory Method
         */
        public static function getInstance( key:String = "default" ) : AutorFacade
        {
            if ( instanceMap[ key ] == null ) instanceMap[ key ] = new AutorFacade( key );
            return instanceMap[ key ] as AutorFacade;
        }
        
        /**
         * Register Commands with the Controller 
         */
        override protected function initializeController( ) : void 
        {
            super.initializeController();
            //STARTUP COMMANDS
            registerCommand( CommandConstants.MODEL_STARTUP, ModelStartupCommand );
            registerCommand( CommandConstants.AUTOR_STARTUP, AutorStartupCommand );
            
            //DISPOSE COMMANDS
            //registerCommand( CommandConstants.DISPOSE_LOGIN_PANEL, LoginPanelDisposeCommand );
        }
        
        /**
         * Application startup
         * 
         * @param app a reference to the application component 
         */
        public function startup( app:Object ):void
        {
        	if (app == "model") sendNotification( CommandConstants.MODEL_STARTUP, null );
        	else if (app is Autor) sendNotification( CommandConstants.AUTOR_STARTUP, app );
        }
	}
}