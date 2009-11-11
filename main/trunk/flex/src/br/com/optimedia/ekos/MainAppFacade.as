package br.com.optimedia.ekos
{
	
	import br.com.optimedia.assets.constants.CommandConstants;
	import br.com.optimedia.ekos.shell.controler.StartupCommand;
	
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	

	public class MainAppFacade extends Facade
	{
		
		[Bindable]
		public var lng:XML = new XML();
		
		public function MainAppFacade(key:String)
		{
			super(key);
		}

		/**
         * Singleton ApplicationFacade Factory Method
         */
        public static function getInstance( key:String = "default" ) : MainAppFacade
        {
            if ( instanceMap[ key ] == null ) instanceMap[ key ] = new MainAppFacade( key );
            return instanceMap[ key ] as MainAppFacade;
        }
        
        /**
         * Register Commands with the Controller 
         */
        override protected function initializeController( ) : void 
        {
            super.initializeController();
            registerCommand( CommandConstants.STARTUP_MAIN_APP, StartupCommand );
        }
        
        /**
         * Application startup
         * 
         * @param app a reference to the application component 
         */
        public function startup( app:Object ):void
        {
        	if (app is MainApp) sendNotification( CommandConstants.STARTUP_MAIN_APP, app );
        }
	}
}