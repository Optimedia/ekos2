package shell
{
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	import shell.controler.StartupCommand;

	public class MainAppFacade extends Facade
	{
		public static const STARTUP:String = 'STARTUP';
		
		[Bindable]
		public var lng:XML = new XML();
		
		// STARTUP COMMANDS CONSTANTS
		//public static const STARTUP_CATEGORYPOPUP:String = 'STARTUP_CATEGORYPOPUP';
		
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
        public static function getInstance( key:String ) : MainAppFacade 
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
            registerCommand( STARTUP, StartupCommand );
            
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
        public function startup( app:MainApp ):void
        {
        	sendNotification( STARTUP, app );
        }
	}
}