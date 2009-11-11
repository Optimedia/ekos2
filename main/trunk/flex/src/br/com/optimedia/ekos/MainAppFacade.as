package br.com.optimedia.ekos
{
	
	import br.com.optimedia.ekos.shell.controler.StartupCommand;
	
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	

	public class MainAppFacade extends Facade
	{
		
		[Bindable]
		public var lng:XML = new XML();
		
		// STARTUP COMMANDS CONSTANTS
		public static const STARTUP_MAIN_APP:String = 'STARTUP_MAIN_APP';
		
		// DISPOSE COMMANDS CONSTANTS
		//public static const DISPOSE_CATEGORYPOPUP:String = "DISPOSE_CATEGORYPOPUP";
		
		// EVENTS
		//public static const NEW_CATEGORYPOPUP_EVENT:String = "NEW_CATEGORYPOPUP_EVENT";
		
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
            registerCommand( STARTUP_MAIN_APP, StartupCommand );
            
            // STARTUP COMMANDS
            //registerCommand( STARTUP_CATEGORYPOPUP, StartupCategoryPopUpCommand );
            
            // DISPOSE COMMANDS
            //registerCommand( DISPOSE_CATEGORYPOPUP, DisposeCategoryPopUpCommand );
        }
        
        /**
         * Application startup
         * 
         * @param app a reference to the application component 
         */
        public function startup( app:Object ):void
        {
        	if (app is MainApp) sendNotification( STARTUP_MAIN_APP, app );
        }
	}
}