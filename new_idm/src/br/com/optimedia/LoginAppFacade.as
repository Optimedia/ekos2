package br.com.optimedia
{
	import br.com.optimedia.assets.CommandConstants;
	import br.com.optimedia.assets.vo.UserVO;
	import br.com.optimedia.login.controller.AtivarContaPopUpDisposeCommand;
	import br.com.optimedia.login.controller.AtivarContaPopUpStartupCommand;
	import br.com.optimedia.login.controller.LembrarSenhaPopUpDisposeCommand;
	import br.com.optimedia.login.controller.LembrarSenhaPopUpStartupCommand;
	import br.com.optimedia.login.controller.LoginAppDisposeCommand;
	import br.com.optimedia.login.controller.LoginAppStartupCommand;
	import br.com.optimedia.login.controller.LoginPanelDisposeCommand;
	import br.com.optimedia.login.controller.LoginPanelStartupCommand;
	import br.com.optimedia.login.view.components.AtivarContaPopUp;
	import br.com.optimedia.login.view.components.LembrarSenhaPopup;
	import br.com.optimedia.login.view.components.LoginPanel;
	
	import org.puremvc.as3.multicore.patterns.facade.Facade;

	public class LoginAppFacade extends Facade
	{
		
		[Bindable]
		public var userVO:UserVO = new UserVO();
		
		public function LoginAppFacade(key:String)
		{
			super(key);
		}

		/**
         * Singleton ApplicationFacade Factory Method
         */
        public static function getInstance( key:String = "default" ) : LoginAppFacade
        {
            if ( instanceMap[ key ] == null ) instanceMap[ key ] = new LoginAppFacade( key );
            return instanceMap[ key ] as LoginAppFacade;
        }
        
        /**
         * Register Commands with the Controller 
         */
        override protected function initializeController( ) : void 
        {
            super.initializeController();
            //STARTUP DOS PROXYES
            
            
            //STARTUP COMMANDS
			registerCommand( CommandConstants.LOGIN_APP_STARTUP, LoginAppStartupCommand );
			registerCommand( CommandConstants.LOGIN_PANEL_STARTUP, LoginPanelStartupCommand );
			registerCommand( CommandConstants.LEMBRAR_SENHA_POPUP_STARTUP, LembrarSenhaPopUpStartupCommand );
			registerCommand( CommandConstants.ATIVAR_CONTA_POPUP_STARTUP, AtivarContaPopUpStartupCommand );
            
            //DISPOSE COMMANDS
			registerCommand( CommandConstants.LOGIN_APP_DISPOSE, LoginAppDisposeCommand );
			registerCommand( CommandConstants.LOGIN_PANEL_DISPOSE, LoginPanelDisposeCommand );
			registerCommand( CommandConstants.ATIVAR_CONTA_POPUP_DISPOSE, LembrarSenhaPopUpDisposeCommand );
			registerCommand( CommandConstants.ATIVAR_CONTA_POPUP_DISPOSE, AtivarContaPopUpDisposeCommand );
        }
        
        /**
         * Application startup
         * 
         * @param app a reference to the application component 
         */
        public function startup( app:* ):void
        {
        	if (app is LoginApp) sendNotification( CommandConstants.LOGIN_APP_STARTUP, app );
        	else if(app is LoginPanel) sendNotification( CommandConstants.LOGIN_PANEL_STARTUP, app );
        	else if(app is LembrarSenhaPopup) sendNotification( CommandConstants.LEMBRAR_SENHA_POPUP_STARTUP, app );
        	else if(app is AtivarContaPopUp) sendNotification( CommandConstants.ATIVAR_CONTA_POPUP_STARTUP, app );
        }
        
        public function dispose( app:* ):void
        {
        	if (app is LoginApp) sendNotification( CommandConstants.LOGIN_APP_DISPOSE, app );
        	else if(app is LoginPanel) sendNotification( CommandConstants.LOGIN_PANEL_DISPOSE, app );
        	else if(app is LembrarSenhaPopup) sendNotification( CommandConstants.LEMBRAR_SENHA_POPUP_DISPOSE, app );
        	else if(app is AtivarContaPopUp) sendNotification( CommandConstants.ATIVAR_CONTA_POPUP_DISPOSE, app );
        }
	}
}