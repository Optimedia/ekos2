package br.com.optimedia.interactive
{
	import br.com.optimedia.interactive.assets.ApplicationConstants;
	import br.com.optimedia.interactive.controller.InteractiveStartupCommand;
	import br.com.optimedia.interactive.controller.SlideViewStartupCommand;
	import br.com.optimedia.interactive.view.components.NavigatorView;
	import br.com.optimedia.interactive.view.components.SlideView;
	
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
            //STARTUP COMMANDS
            registerCommand( ApplicationConstants.APPLICATION_STARTUP, InteractiveStartupCommand );
            registerCommand( ApplicationConstants.SLIDE_VIEW_STARTUP, SlideViewStartupCommand );
            registerCommand( ApplicationConstants.NAVIGATOR_VIEW_STARTUP, SlideViewStartupCommand );
            
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
        }
        
        public function dispose( app:Object ):void
        {
        	//if (app == LoginWindow) sendNotification( CommandConstants.LOGIN_WINDOW_DISPOSE, app );
        }
	}
}