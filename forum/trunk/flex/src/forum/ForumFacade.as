package forum
{
	import flash.events.Event;
	
	import forum.controler.DisposeCategoryPopUpCommand;
	import forum.controler.StartupAvatarBoxCommand;
	import forum.controler.StartupCategoryPopUpCommand;
	import forum.controler.StartupCommand;
	import forum.view.AvatarBoxMediator;
	import forum.view.CategoryPopUpMediator;
	import forum.view.component.AvatarBox;
	import forum.view.component.CategoryPopUp;
	
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	

	public class ForumFacade extends Facade
	{
		public static const STARTUP:String = 'STARTUP';
		
		[Bindable]
		public var lng:XML = new XML();
		
		// STARTUP COMMANDS CONSTANTS
		public static const STARTUP_CATEGORYPOPUP:String = 'STARTUP_CATEGORYPOPUP';
		public static const STARTUP_AVATARBOX:String = 'STARTUP_AVATARBOX';
		
		// DISPOSE COMMANDS CONSTANTS
		public static const DISPOSE_CATEGORYPOPUP:String = "DISPOSE_CATEGORYPOPUP";
		
		// EVENTS
		public static const NEW_CATEGORYPOPUP_EVENT:String = "NEW_CATEGORYPOPUP_EVENT";
		
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
            
            // STARTUP COMMANDS
            registerCommand( STARTUP_CATEGORYPOPUP, StartupCategoryPopUpCommand );
            registerCommand( STARTUP_AVATARBOX, StartupAvatarBoxCommand );
            
            // DISPOSE COMMANDS
            registerCommand( DISPOSE_CATEGORYPOPUP, DisposeCategoryPopUpCommand );
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
        
        public function startupCategoryPopUp( view:CategoryPopUp ):void {
        	if( !this.hasMediator( CategoryPopUpMediator.NAME ) ) {
	        	sendNotification( STARTUP_CATEGORYPOPUP, view );
        	}
        }
        public function disposeCategoryPopUp():void {
        	if( this.hasMediator( CategoryPopUpMediator.NAME ) ) {
	        	sendNotification( DISPOSE_CATEGORYPOPUP );
        	}
        }
        
        public function startupAvatarBox( view:AvatarBox ):void {
	        	sendNotification( STARTUP_AVATARBOX, view );
        	if( !this.hasMediator( AvatarBoxMediator.NAME ) ) {
        	}
        }
	}
}