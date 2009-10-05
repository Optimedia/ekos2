package forum
{
	import forum.controler.StartupCommand;
	
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	

	public class ForumFacade extends Facade
	{
		public static const STARTUP:String = 'STARTUP';
		
		public function ForumFacade(key:String)
		{
			super(key);
		}

		/**
         * Singleton ApplicationFacade Factory Method
         */
        public static function getInstance( key:String ) : ForumFacade 
        {
            if ( instanceMap[ key ] == null ) instanceMap[ key ] = new ForumFacade( key );
            return instanceMap[ key ] as ForumFacade;
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
        public function startup( app:Forum ):void
        {
        	sendNotification( STARTUP, app );
        }
	}
}