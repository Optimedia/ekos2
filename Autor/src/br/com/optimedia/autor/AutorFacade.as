package br.com.optimedia.autor
{
	import br.com.optimedia.autor.assets.CommandConstants;
	import br.com.optimedia.autor.controller.AutorStartupCommand;
	import br.com.optimedia.autor.controller.ModelStartupCommand;
	import br.com.optimedia.autor.view.components.SubjectManager;
	
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	import br.com.optimedia.autor.controller.SubjectManagerStartupCommand;
	import br.com.optimedia.autor.view.components.RepositoryPanel;
	import br.com.optimedia.autor.controller.RepositoryPanelStartupCommand;

	public class AutorFacade extends Facade
	{
		
		public function AutorFacade(key:String)
		{
			super(key);
		}

		/**
         * Singleton ApplicationFacade Factory Method
         */
        public static function getInstance( key:String = "default" ) : AutorFacade
        {
            if ( instanceMap[ key ] == null ) instanceMap[ key ] = new AutorFacade( key );
            return instanceMap[ key ] as AutorFacade;
        }
        
        /**
         * Register Commands with the Controller 
         */
        override protected function initializeController( ) : void 
        {
            super.initializeController();
            //STARTUP COMMANDS
            registerCommand( CommandConstants.MODEL_STARTUP, ModelStartupCommand );
            registerCommand( CommandConstants.AUTOR_STARTUP, AutorStartupCommand );
            registerCommand( CommandConstants.SUBJECT_MANAGER_STARTUP, SubjectManagerStartupCommand );
            registerCommand( CommandConstants.REPOSITORY_PANEL_STARTUP, RepositoryPanelStartupCommand );
            
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
        	if (app == "model") sendNotification( CommandConstants.MODEL_STARTUP, null );
        	else if (app is Autor) sendNotification( CommandConstants.AUTOR_STARTUP, app );
        	else if (app is SubjectManager) sendNotification( CommandConstants.SUBJECT_MANAGER_STARTUP, app );
        	else if (app is RepositoryPanel) sendNotification( CommandConstants.REPOSITORY_PANEL_STARTUP, app );
        }
        
        public function dispose( app:Object ):void
        {
        	//if (app == LoginWindow) sendNotification( CommandConstants.LOGIN_WINDOW_DISPOSE, app );
        }
	}
}