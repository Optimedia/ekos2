package br.com.optimedia.notifier.shell
{
	
	
	import br.com.optimedia.notifier.shell.controler.DisposePopNotifierCommand;
	import br.com.optimedia.notifier.shell.controler.StartupCommand;
	import br.com.optimedia.notifier.shell.controler.StartupPopNotifierCommand;
	import br.com.optimedia.notifier.shell.view.component.PopNotifier;
	
	import mx.resources.ResourceBundle;
	
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	
	
	//Metatags de todos os ResourceBundle's. Podem ser concatenadas. Devem estar sempre imediatamente antes da class
	//[ResourceBundle("locale")]
	
	public class NotifierFacade extends Facade
	{
		private var teste:ResourceBundle;
	 	public static const STARTUP:String = 'STARTUP';
		public static const STARTUP_POPNOTIFIER:String = 'STARTUP_POPNOTIFIER';
		public static const DISPOSE_POPNOTIFIER:String = 'DISPOSE_POPNOTIFIER';
		
		//ResourceManager instance

		//public var language:IResourceManager = ResourceManager.getInstance();
		
		public function NotifierFacade(key:String)
		{
			super(key);
		}

		/**
         * Singleton ApplicationFacade Factory Method
         */
        public static function getInstance( key:String ) : NotifierFacade 
        {
            if ( instanceMap[ key ] == null ) instanceMap[ key ] = new NotifierFacade( key );
            return instanceMap[ key ] as NotifierFacade;
        }
        
        /**
         * Register Commands with the Controller 
         */
        override protected function initializeController( ) : void 
        {
            super.initializeController();
            
            // STARTUP COMMANDS
            registerCommand( STARTUP, StartupCommand );
            registerCommand( STARTUP_POPNOTIFIER, StartupPopNotifierCommand );
            
            //DISPOSE COMMANDS
            registerCommand( DISPOSE_POPNOTIFIER, DisposePopNotifierCommand );
            
            //Define a órdem de prioridades das línguas
            //language.localeChain = ['pt_BR','en_US'];
        }
        
        /**
         * Application startup
         * 
         * @param app a reference to the application component 
         */
        public function startup( app:Notifier ):void
        {
        	sendNotification( STARTUP, app );
        }
		
		public function startupPopNotifier( app:PopNotifier ):void {
			sendNotification( STARTUP_POPNOTIFIER, app );
		}
		public function disposePopNotifier( app:PopNotifier ):void {
			sendNotification( DISPOSE_POPNOTIFIER, app );
		}
	}
}