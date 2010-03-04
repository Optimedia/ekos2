package br.com.optimedia.player
{
	import br.com.optimedia.assets.CommandConstants;
	import br.com.optimedia.player.controller.PlayerModuleStartupCommand;
	import br.com.optimedia.player.model.PlayerSlideManagerProxy;
	
	import org.puremvc.as3.multicore.patterns.facade.Facade;

	public class PlayerFacade extends Facade
	{
		public function PlayerFacade(key:String)
		{
			super(key);
		}

		/**
         * Singleton ApplicationFacade Factory Method
         */
        public static function getInstance( key:String = "player" ) : PlayerFacade
        {
            if ( instanceMap[ key ] == null ) instanceMap[ key ] = new PlayerFacade( key );
            return instanceMap[ key ] as PlayerFacade;
        }
        
        /**
         * Register Commands with the Controller 
         */
        override protected function initializeController( ) : void 
        {
            super.initializeController();
            
            this.registerProxy( new PlayerSlideManagerProxy() );
            
            //STARTUP COMMANDS
			registerCommand( CommandConstants.PLAYER_MODULE_STARTUP, PlayerModuleStartupCommand );
            
            //DISPOSE COMMANDS
			//registerCommand( CommandConstants.SEND_FILE_POPUP_DISPOSE, SendFilePopUpDisposeCommand );
        }
        
        /**
         * Application startup
         * 
         * @param app a reference to the application component 
         */
        public function startup( app:Object ):void
        {
        	if(app is PlayerModule) sendNotification( CommandConstants.PLAYER_MODULE_STARTUP, app );
        }
        
        public function dispose( app:Object ):void
        {
        	//if (app == SendFilePopUp) sendNotification( CommandConstants.SEND_FILE_POPUP_DISPOSE, app );
        }
	}
}