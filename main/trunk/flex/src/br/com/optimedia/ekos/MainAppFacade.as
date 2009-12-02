package br.com.optimedia.ekos
{
	
	import br.com.optimedia.assets.constants.CommandConstants;
	import br.com.optimedia.ekos.shell.controler.AvatarBoxDisposeCommand;
	import br.com.optimedia.ekos.shell.controler.AvatarBoxStartupCommand;
	import br.com.optimedia.ekos.shell.controler.LoginPanelDisposeCommand;
	import br.com.optimedia.ekos.shell.controler.LoginPanelStartupCommand;
	import br.com.optimedia.ekos.shell.controler.StartupCommand;
	import br.com.optimedia.ekos.shell.view.component.AvatarBox;
	import br.com.optimedia.ekos.shell.view.component.LoginPanel;
	
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	import br.com.optimedia.assets.vo.CompleteUserVO;
	

	public class MainAppFacade extends Facade
	{
		
		[Bindable]
		public var lng:XML = new XML();
		
		[Bindable]
		public var myCompleteUserVO:CompleteUserVO = new CompleteUserVO();
		
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
            //STARTUP COMMANDS
            registerCommand( CommandConstants.STARTUP_MAIN_APP, StartupCommand );
            registerCommand( CommandConstants.STARTUP_LOGIN_PANEL, LoginPanelStartupCommand );
            registerCommand( CommandConstants.STARTUP_AVATAR_BOX, AvatarBoxStartupCommand );
            
            //DISPOSE COMMANDS
            registerCommand( CommandConstants.DISPOSE_LOGIN_PANEL, LoginPanelDisposeCommand );
            registerCommand( CommandConstants.DISPOSE_AVATAR_BOX, AvatarBoxDisposeCommand );
        }
        
        /**
         * Application startup
         * 
         * @param app a reference to the application component 
         */
        public function startup( app:Object ):void
        {
        	if (app is MainApp) sendNotification( CommandConstants.STARTUP_MAIN_APP, app );
        	if (app is LoginPanel) sendNotification( CommandConstants.STARTUP_LOGIN_PANEL, app );
        	if (app is AvatarBox) sendNotification( CommandConstants.STARTUP_AVATAR_BOX, app );
        }
	}
}