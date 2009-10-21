package shell
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.utils.StringUtil;
	
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	import shell.controler.DisposePopBookCommand;
	import shell.controler.StartupCommand;
	import shell.controler.StartupPopBookCommand;
	import shell.view.component.PopBook;
	
	public class BookmarkFacade extends Facade
	{
	 	public static const STARTUP:String = 'STARTUP';
		public static const STARTUP_POPBOOK:String = 'STARTUP_POPBOOK';
		public static const DISPOSE_POPBOOK:String = 'DISPOSE_POPBOOK';
		
		public static const DEFAULT_RESOURCE_BUNDLE_XML:String = "bundle/pt-br.xml";
		
		public var bundleXML:XML;
		
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
        }
        
        /**
         * Application startup
         * 
         * @param app a reference to the application component 
         */
        public function startup( app:Bookmark ):void
        {
        	loadBundle(DEFAULT_RESOURCE_BUNDLE_XML);
        	sendNotification( STARTUP, app );
        }
		
		public function startupPopBook( app:PopBook ):void {
			sendNotification( STARTUP_POPBOOK, app );
		}
		public function disposePopBook( app:PopBook ):void {
			sendNotification( DISPOSE_POPBOOK, app );
		}
		
		private function loadBundle(url:String):void
        {
            var request:URLLoader = new URLLoader;
            request.addEventListener(Event.COMPLETE, RecebeXML);
            request.load(new URLRequest( url ));
                
            function RecebeXML(e:Event):void
	        {
	            bundleXML = new XML(e.target.data);
	        }
        }
        
        public function getString(name:String):String {
        	return bundleXML.bkm[name];
        }
	}
}