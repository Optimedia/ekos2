package br.com.optimedia.ekos
{
	
	import br.com.optimedia.assets.constants.CommandConstants;
	import br.com.optimedia.ekos.contentcontainer.controller.ContentContainerDisposeCommand;
	import br.com.optimedia.ekos.contentcontainer.controller.ContentContainerStartupCommand;
	import br.com.optimedia.ekos.contentcontainer.view.components.ContentContainer;
	import br.com.optimedia.ekos.shell.controller.AvatarBoxDisposeCommand;
	import br.com.optimedia.ekos.shell.controller.AvatarBoxStartupCommand;
	import br.com.optimedia.ekos.shell.controller.ChangeAvatarPopUpDisposeCommand;
	import br.com.optimedia.ekos.shell.controller.ChangeAvatarPopUpStartupCommand;
	import br.com.optimedia.ekos.shell.controller.EditProfileStartupCommand;
	import br.com.optimedia.ekos.shell.controller.FriendsViewStartupCommand;
	import br.com.optimedia.ekos.shell.controller.LoginPanelDisposeCommand;
	import br.com.optimedia.ekos.shell.controller.LoginPanelStartupCommand;
	import br.com.optimedia.ekos.shell.controller.MailBoxViewStartupCommand;
	import br.com.optimedia.ekos.shell.controller.ModelStartupCommand;
	import br.com.optimedia.ekos.shell.controller.SendPrivateMessagePopUpDisposeCommand;
	import br.com.optimedia.ekos.shell.controller.SendPrivateMessagePopUpStartupCommand;
	import br.com.optimedia.ekos.shell.controller.StartupCommand;
	import br.com.optimedia.ekos.shell.view.component.AvatarBox;
	import br.com.optimedia.ekos.shell.view.component.ChangeAvatarPopUp;
	import br.com.optimedia.ekos.shell.view.component.EditProfile;
	import br.com.optimedia.ekos.shell.view.component.FriendsView;
	import br.com.optimedia.ekos.shell.view.component.LoginPanel;
	import br.com.optimedia.ekos.shell.view.component.MailBoxView;
	import br.com.optimedia.ekos.shell.view.component.SendPrivateMessagePopUp;
	
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	

	public class MainAppFacade extends Facade
	{
		
		[Bindable]
		public var lng:XML = new XML();
		
		/* [Bindable]
		public var myCompleteUserVO:CompleteUserVO = new CompleteUserVO(); */
		
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
            registerCommand( CommandConstants.STARTUP_MODEL, ModelStartupCommand );
            registerCommand( CommandConstants.STARTUP_MAIN_APP, StartupCommand );
            registerCommand( CommandConstants.STARTUP_LOGIN_PANEL, LoginPanelStartupCommand );
            registerCommand( CommandConstants.STARTUP_AVATAR_BOX, AvatarBoxStartupCommand );
            registerCommand( CommandConstants.STARTUP_CHANGE_AVATAR_POPUP, ChangeAvatarPopUpStartupCommand );
            registerCommand( CommandConstants.STARTUP_EDIT_PROFILE, EditProfileStartupCommand );
            registerCommand( CommandConstants.STARTUP_FRIENDS_VIEW, FriendsViewStartupCommand );
            registerCommand( CommandConstants.STARTUP_SEND_PRIVATE_MESSAGE_POPUP, SendPrivateMessagePopUpStartupCommand );
            registerCommand( CommandConstants.STARTUP_MAIL_BOX_VIEW, MailBoxViewStartupCommand );
            registerCommand( CommandConstants.STARTUP_CONTENT_CONTAINER, ContentContainerStartupCommand );
            
            //DISPOSE COMMANDS
            registerCommand( CommandConstants.DISPOSE_LOGIN_PANEL, LoginPanelDisposeCommand );
            registerCommand( CommandConstants.DISPOSE_AVATAR_BOX, AvatarBoxDisposeCommand );
            registerCommand( CommandConstants.DISPOSE_CHANGE_AVATAR_POPUP, ChangeAvatarPopUpDisposeCommand );
            registerCommand( CommandConstants.DISPOSE_SEND_PRIVATE_MESSAGE_POPUP, SendPrivateMessagePopUpDisposeCommand );
            registerCommand( CommandConstants.DISPOSE_CONTENT_CONTAINER, ContentContainerDisposeCommand );
        }
        
        /**
         * Application startup
         * 
         * @param app a reference to the application component 
         */
        public function startup( app:Object ):void
        {
        	if (app == "model") sendNotification( CommandConstants.STARTUP_MODEL, null );
        	if (app is MainApp) sendNotification( CommandConstants.STARTUP_MAIN_APP, app );
        	if (app is LoginPanel) sendNotification( CommandConstants.STARTUP_LOGIN_PANEL, app );
        	if (app is AvatarBox) sendNotification( CommandConstants.STARTUP_AVATAR_BOX, app );
        	if (app is ChangeAvatarPopUp) sendNotification( CommandConstants.STARTUP_CHANGE_AVATAR_POPUP, app );
        	if (app is EditProfile) sendNotification( CommandConstants.STARTUP_EDIT_PROFILE, app );
        	if (app is FriendsView) sendNotification( CommandConstants.STARTUP_FRIENDS_VIEW, app );
        	if (app is SendPrivateMessagePopUp) sendNotification( CommandConstants.STARTUP_SEND_PRIVATE_MESSAGE_POPUP, app );
        	if (app is MailBoxView) sendNotification( CommandConstants.STARTUP_MAIL_BOX_VIEW, app );
        	if (app is ContentContainer) sendNotification( CommandConstants.STARTUP_CONTENT_CONTAINER, app );
        }
	}
}