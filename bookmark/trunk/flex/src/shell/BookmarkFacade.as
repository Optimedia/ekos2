package shell
{
	
	import mx.resources.IResourceManager;
	import mx.resources.ResourceBundle;
	import mx.resources.ResourceManager;
	
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	import shell.controler.DisposePopBookCommand;
	import shell.controler.StartupCommand;
	import shell.controler.StartupPopBookCommand;
	import shell.view.component.PopBook;
	
	//Metatags de todos os ResourceBundle's. Podem ser concatenadas. Devem estar sempre imediatamente antes da class
	[ResourceBundle("locale")]
	
	public class BookmarkFacade extends Facade
	{
		private var teste:ResourceBundle;
	 	public static const STARTUP:String = 'STARTUP';
		public static const STARTUP_POPBOOK:String = 'STARTUP_POPBOOK';
		public static const DISPOSE_POPBOOK:String = 'DISPOSE_POPBOOK';
		
		//ResourceManager instance
		[Bindable]
		public var language:IResourceManager = ResourceManager.getInstance();
		
		public function BookmarkFacade(key:String)
		{
			super(key);
		}

		/**
         * Singleton ApplicationFacade Factory Method
         */
        public static function getInstance( key:String ) : BookmarkFacade 
        {
            if ( instanceMap[ key ] == null ) instanceMap[ key ] = new BookmarkFacade( key );
            return instanceMap[ key ] as BookmarkFacade;
        }
        
        /**
         * Register Commands with the Controller 
         */
        override protected function initializeController( ) : void 
        {
            super.initializeController();
            
            // STARTUP COMMANDS
            registerCommand( STARTUP, StartupCommand );
            registerCommand( STARTUP_POPBOOK, StartupPopBookCommand );
            
            //DISPOSE COMMANDS
            registerCommand( DISPOSE_POPBOOK, DisposePopBookCommand );
            
            //Define a órdem de prioridades das línguas
            language.localeChain = ['pt_BR','en_US'];
        }
        
        /**
         * Application startup
         * 
         * @param app a reference to the application component 
         */
        public function startup( app:Bookmark ):void
        {
        	sendNotification( STARTUP, app );
        }
		
		public function startupPopBook( app:PopBook ):void {
			sendNotification( STARTUP_POPBOOK, app );
		}
		public function disposePopBook( app:PopBook ):void {
			sendNotification( DISPOSE_POPBOOK, app );
		}
		
		//Seta uma língua
		public function set locale(string:String):void {
			language.localeChain = [string];
		}
	}
}