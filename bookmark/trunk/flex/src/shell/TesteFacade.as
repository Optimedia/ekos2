package shell
{
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	import shell.controler.StartupCommand;

	public class TesteFacade extends Facade
	{
		public static const STARTUP:String = 'STARTUP';
		
		public function TesteFacade(key:String)
		{
			super(key);
		}

		/**
         * Singleton ApplicationFacade Factory Method
         */
        public static function getInstance( key:String ) : TesteFacade 
        {
            if ( instanceMap[ key ] == null ) instanceMap[ key ] = new TesteFacade( key );
            return instanceMap[ key ] as TesteFacade;
        }
        
        /**
         * Register Commands with the Controller 
         */
        override protected function initializeController( ) : void 
        {
            super.initializeController();
            registerCommand( STARTUP, StartupCommand );
        }
        
        /**
         * Application startup
         * 
         * @param app a reference to the application component 
         */
        public function startup( app:Teste ):void
        {
        	sendNotification( STARTUP, app );
        }
	}
}