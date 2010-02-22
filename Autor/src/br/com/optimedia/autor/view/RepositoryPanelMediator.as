package br.com.optimedia.autor.view
{
	import br.com.optimedia.autor.assets.NotificationConstants;
	import br.com.optimedia.autor.model.RepositoryManagerProxy;
	import br.com.optimedia.autor.view.components.RepositoryPanel;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import br.com.optimedia.autor.assets.vo.MediaVO;
	import mx.controls.Alert;
	import mx.events.CloseEvent;

	public class RepositoryPanelMediator extends Mediator
	{
		public static const NAME:String = 'RepositoryPanelMediator';
		
		private var proxy:RepositoryManagerProxy;
		
		private var presentationID:uint;
		
		public function RepositoryPanelMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			view.deleteBtn.addEventListener( MouseEvent.CLICK, deleteMedia );
			proxy = facade.retrieveProxy( RepositoryManagerProxy.NAME ) as RepositoryManagerProxy;
		}
		
		override public function onRemove():void {
			
		}
		
		public function get view():RepositoryPanel
		{
			return viewComponent as RepositoryPanel;
		}
		
		override public function listNotificationInterests():Array
		{
			return [NotificationConstants.BEGIN_PRESENTATION_EDIT,
					NotificationConstants.GET_MEDIAS_RESULT];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case NotificationConstants.BEGIN_PRESENTATION_EDIT:
					presentationID = note.getBody() as int;
					proxy.getMedias( presentationID );
					break;
				case NotificationConstants.GET_MEDIAS_RESULT:
					//view.hd.source = note.getBody() as Array;
					view.mediaXml = new ArrayCollection(note.getBody() as Array);
					break;
				case NotificationConstants.DELETE_MEDIA_OK:
					proxy.getMedias( presentationID );
					Alert.show("Media removida com sucesso", "OK");
					break;
				default:
					break;
			}
		}
		
		private function deleteMedia(event:MouseEvent):void {
			Alert.noLabel = "Não";
			Alert.yesLabel = "Sim";
			Alert.show("Tem certeza que deseja apagar a media "+MediaVO(view.mediaTree.selectedItem).title+"?", "Atenção",Alert.YES|Alert.NO, null, deleteSubject, null, Alert.NO);
			function deleteSubject(event:CloseEvent):void {
				if(event.detail == Alert.YES) {
					proxy.deleteMedia( MediaVO(view.mediaTree.selectedItem).media_id );
				}
			}
		}
	}
}