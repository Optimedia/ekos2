package br.com.optimedia.autor
{
	import br.com.optimedia.autor.assets.CommandConstants;
	import br.com.optimedia.autor.controller.AutorStartupCommand;
	import br.com.optimedia.autor.controller.ModelStartupCommand;
	import br.com.optimedia.autor.controller.RepositoryPanelStartupCommand;
	import br.com.optimedia.autor.controller.SendFilePopUpDisposeCommand;
	import br.com.optimedia.autor.controller.SendFilePopUpStartupCommand;
	import br.com.optimedia.autor.controller.SendMediaDisposeCommand;
	import br.com.optimedia.autor.controller.SendMediaStartupCommand;
	import br.com.optimedia.autor.controller.SlideEditorStartupCommand;
	import br.com.optimedia.autor.controller.SubjectManagerStartupCommand;
	import br.com.optimedia.autor.view.components.RepositoryPanel;
	import br.com.optimedia.autor.view.components.SendFilePopUp;
	import br.com.optimedia.autor.view.components.SendMediaPopUp;
	import br.com.optimedia.autor.view.components.SubjectManager;
	
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	import br.com.optimedia.autor.view.components.SlideEditor;

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
            registerCommand( CommandConstants.SEND_FILE_POPUP_STARTUP, SendFilePopUpStartupCommand );
            registerCommand( CommandConstants.SEND_MEDIA_POPUP_STARTUP, SendMediaStartupCommand );
            registerCommand( CommandConstants.SLIDE_EDITOR_STARTUP, SlideEditorStartupCommand );
            
            //DISPOSE COMMANDS
            registerCommand( CommandConstants.SEND_FILE_POPUP_DISPOSE, SendFilePopUpDisposeCommand );
            registerCommand( CommandConstants.SEND_MEDIA_POPUP_DISPOSE, SendMediaDisposeCommand );
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
        	else if (app is SendFilePopUp) sendNotification( CommandConstants.SEND_FILE_POPUP_STARTUP, app );
        	else if (app is SendMediaPopUp) sendNotification( CommandConstants.SEND_MEDIA_POPUP_STARTUP, app );
        	else if (app is SlideEditor) sendNotification( CommandConstants.SLIDE_EDITOR_STARTUP, app );
        }
        
        public function dispose( app:Object ):void
        {
        	if (app == SendFilePopUp) sendNotification( CommandConstants.SEND_FILE_POPUP_DISPOSE, app );
        	if (app == SendMediaPopUp) sendNotification( CommandConstants.SEND_MEDIA_POPUP_DISPOSE, app );
        }
	}
}