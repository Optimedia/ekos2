package br.com.optimedia.autor.view
{
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import br.com.optimedia.autor.view.components.RepositoryPanel;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import br.com.optimedia.autor.model.RepositoryManagerProxy;
	import br.com.optimedia.autor.assets.vo.PresentationVO;
	import br.com.optimedia.autor.assets.NotificationConstants;

	public class RepositoryPanelMediator extends Mediator
	{
		public static const NAME:String = 'RepositoryPanelMediator';
		
		private var proxy:RepositoryManagerProxy;
		
		public function RepositoryPanelMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			proxy = facade.retrieveProxy( RepositoryManagerProxy.NAME ) as RepositoryManagerProxy;
			proxy.getMedias( view.presentationID );
		}
		
		override public function onRemove():void {
			
		}
		
		public function get view():RepositoryPanel
		{
			return viewComponent as RepositoryPanel;
		}
		
		override public function listNotificationInterests():Array
		{
			return [NotificationConstants.GET_MEDIAS_RESULT];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case NotificationConstants.GET_MEDIAS_RESULT:
					view.mediaXml = note.getBody() as XML;
					break;
				default:
					break;
			}
		}
	}
}