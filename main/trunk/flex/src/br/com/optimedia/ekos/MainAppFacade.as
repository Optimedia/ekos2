package br.com.optimedia.ekos
{
	
	import br.com.optimedia.assets.constants.CommandConstants;
	import br.com.optimedia.assets.vo.CompleteUserVO;
	import br.com.optimedia.ekos.shell.controler.AvatarBoxDisposeCommand;
	import br.com.optimedia.ekos.shell.controler.AvatarBoxStartupCommand;
	import br.com.optimedia.ekos.shell.controler.ChangeAvatarPopUpDisposeCommand;
	import br.com.optimedia.ekos.shell.controler.ChangeAvatarPopUpStartupCommand;
	import br.com.optimedia.ekos.shell.controler.EditProfileStartupCommand;
	import br.com.optimedia.ekos.shell.controler.FriendsViewStartupCommand;
	import br.com.optimedia.ekos.shell.controler.LoginPanelDisposeCommand;
	import br.com.optimedia.ekos.shell.controler.LoginPanelStartupCommand;
	import br.com.optimedia.ekos.shell.controler.StartupCommand;
	import br.com.optimedia.ekos.shell.view.component.AvatarBox;
	import br.com.optimedia.ekos.shell.view.component.ChangeAvatarPopUp;
	import br.com.optimedia.ekos.shell.view.component.EditProfile;
	import br.com.optimedia.ekos.shell.view.component.FriendsView;
	import br.com.optimedia.ekos.shell.view.component.LoginPanel;
	
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	

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
            registerCommand( CommandConstants.STARTUP_CHANGE_AVATAR_POPUP, ChangeAvatarPopUpStartupCommand );
            registerCommand( CommandConstants.STARTUP_EDIT_PROFILE, EditProfileStartupCommand );
            registerCommand( CommandConstants.STARTUP_FRIENDS_VIEW, FriendsViewStartupCommand );
            
            //DISPOSE COMMANDS
            registerCommand( CommandConstants.DISPOSE_LOGIN_PANEL, LoginPanelDisposeCommand );
            registerCommand( CommandConstants.DISPOSE_AVATAR_BOX, AvatarBoxDisposeCommand );
            registerCommand( CommandConstants.DISPOSE_CHANGE_AVATAR_POPUP, ChangeAvatarPopUpDisposeCommand );
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
        	if (app is ChangeAvatarPopUp) sendNotification( CommandConstants.STARTUP_CHANGE_AVATAR_POPUP, app );
        	if (app is EditProfile) sendNotification( CommandConstants.STARTUP_EDIT_PROFILE, app );
        	if (app is FriendsView) sendNotification( CommandConstants.STARTUP_FRIENDS_VIEW, app );
        }
	}
}