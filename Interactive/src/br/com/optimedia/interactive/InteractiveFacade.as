package br.com.optimedia.interactive
{
	import br.com.optimedia.interactive.assets.ApplicationConstants;
	import br.com.optimedia.interactive.controller.InteractiveStartupCommand;
	import br.com.optimedia.interactive.controller.MenuViewStartupCommand;
	import br.com.optimedia.interactive.controller.MidiaStartupCommand;
	import br.com.optimedia.interactive.controller.NavigatorViewStartupCommand;
	import br.com.optimedia.interactive.controller.SlideViewStartupCommand;
	import br.com.optimedia.interactive.model.InteractiveProxy;
	import br.com.optimedia.interactive.view.InteractiveMediator;
	import br.com.optimedia.interactive.view.SlideMediator;
	import br.com.optimedia.interactive.view.components.MenuView;
	import br.com.optimedia.interactive.view.components.MidiaView;
	import br.com.optimedia.interactive.view.components.NavigatorView;
	import br.com.optimedia.interactive.view.components.SlideView;
	
	import mx.core.Application;
	
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	
	public class InteractiveFacade extends Facade{
		
		public function InteractiveFacade(key:String)
		{
			super(key);
		}

		/**
         * Singleton ApplicationFacade Factory Method
         */
        public static function getInstance( key:String = "default" ) : InteractiveFacade
        {
            if ( instanceMap[ key ] == null ) instanceMap[ key ] = new InteractiveFacade( key );
            return instanceMap[ key ] as InteractiveFacade;
        }
        
        /**
         * Register Commands with the Controller 
         */
        override protected function initializeController( ) : void 
        {
            super.initializeController();

			// PROXY
			this.registerProxy(new InteractiveProxy());
			
			// MEDIATOR
			this.registerMediator(new InteractiveMediator(Application.application));
			this.registerMediator(new SlideMediator(Application.application.slideView));

            //STARTUP COMMANDS
            this.registerCommand( ApplicationConstants.APPLICATION_STARTUP, InteractiveStartupCommand );
            this.registerCommand( ApplicationConstants.SLIDE_VIEW_STARTUP, SlideViewStartupCommand );
            this.registerCommand( ApplicationConstants.NAVIGATOR_VIEW_STARTUP, NavigatorViewStartupCommand );
            this.registerCommand( ApplicationConstants.MENU_VIEW_STARTUP, MenuViewStartupCommand );
            this.registerCommand( ApplicationConstants.MIDIA_VIEW_STARTUP, MidiaStartupCommand );
            
            //DISPOSE COMMANDS
            //registerCommand( CommandConstants.LOGIN_WINDOW_DISPOSE, LoginWindowDisposeCommand );
        }
        
        /**
         * Application startup
         * 
         * @param app a reference to the application component 
         */
        public function startup( app:Object ):void
        {
        	if (app is Interactive) sendNotification( ApplicationConstants.APPLICATION_STARTUP, app );
        	else if (app is SlideView) sendNotification( ApplicationConstants.SLIDE_VIEW_STARTUP, app );
        	else if (app is NavigatorView) sendNotification( ApplicationConstants.NAVIGATOR_VIEW_STARTUP, app );
        	else if (app is MenuView) sendNotification( ApplicationConstants.MENU_VIEW_STARTUP, app );
        	else if (app is MidiaView) sendNotification( ApplicationConstants.MIDIA_VIEW_STARTUP, app );
        }
        
        public function dispose( app:Object ):void
        {
        	//if (app == LoginWindow) sendNotification( CommandConstants.LOGIN_WINDOW_DISPOSE, app );
        }
	}
}