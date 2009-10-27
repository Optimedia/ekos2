package forum
{
	import forum.controler.DisposeAdminViewCommand;
	import forum.controler.DisposeCategoryPopUpCommand;
	import forum.controler.StartupAdminViewCommand;
	import forum.controler.StartupAvatarBoxCommand;
	import forum.controler.StartupCategoryPopUpCommand;
	import forum.controler.StartupCommand;
	import forum.view.AvatarBoxMediator;
	import forum.view.CategoryPopUpMediator;
	import forum.view.component.AvatarBox;
	import forum.view.component.CategoryPopUp;
	
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	import forum.view.component.AdminView;
	import forum.view.AdminViewMediator;
	

	public class ForumFacade extends Facade
	{
		public static const STARTUP:String = 'STARTUP';
		
		[Bindable]
		public var lng:XML = new XML();
		
		// STARTUP COMMANDS CONSTANTS
		public static const STARTUP_CATEGORYPOPUP:String = 'STARTUP_CATEGORYPOPUP';
		public static const STARTUP_AVATARBOX:String = 'STARTUP_AVATARBOX';
		public static const STARTUP_ADMINVIEW:String = 'STARTUP_ADMINVIEW';
		
		// DISPOSE COMMANDS CONSTANTS
		public static const DISPOSE_CATEGORYPOPUP:String = "DISPOSE_CATEGORYPOPUP";
		public static const DISPOSE_ADMINVIEW:String = 'DISPOSE_ADMINVIEW';
		
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
            registerCommand( STARTUP_ADMINVIEW, StartupAdminViewCommand );
            
            // DISPOSE COMMANDS
            registerCommand( DISPOSE_CATEGORYPOPUP, DisposeCategoryPopUpCommand );
            registerCommand( DISPOSE_ADMINVIEW, DisposeAdminViewCommand );
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
        }
        
        public function startupAdminView( view:AdminView ):void {
        	if( !this.hasMediator( AdminViewMediator.NAME ) ) {
	        	sendNotification( STARTUP_ADMINVIEW, view );
        	}
        }
        public function disposeAdminView():void {
        	if( this.hasMediator( AdminViewMediator.NAME ) ) {
	        	sendNotification( DISPOSE_ADMINVIEW );
        	}
        }
	}
}