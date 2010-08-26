package br.com.optimedia.autor.view
{
	import br.com.optimedia.assets.NotificationConstants;
	import br.com.optimedia.assets.vo.MediaVO;
	import br.com.optimedia.autor.AutorFacade;
	import br.com.optimedia.autor.model.RepositoryManagerProxy;
	import br.com.optimedia.autor.view.components.InsertImgPopUp;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.System;
	
	import mx.collections.ArrayCollection;
	import mx.events.CloseEvent;
	import mx.events.FlexEvent;
	import mx.events.ListEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class InsertImgPopUpMediator extends Mediator
	{
		public static const NAME:String = 'InsertImgPopUpMediator';
		
		private var repositoryManager:RepositoryManagerProxy;
		
		public function InsertImgPopUpMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			repositoryManager = facade.retrieveProxy( RepositoryManagerProxy.NAME ) as RepositoryManagerProxy;
			repositoryManager.getAllImgs( view.subjectID );
			view.insertBtn.addEventListener(MouseEvent.CLICK, insertHandler);
			view.cancelBtn.addEventListener(MouseEvent.CLICK, closeMe);
			view.addEventListener(CloseEvent.CLOSE, closeMe);
			view.comboBox.addEventListener(ListEvent.CHANGE, comboHandler);
		}
		
		override public function onRemove():void {
			view.removeMe();
			System.gc();
		}
		
		public function get view():InsertImgPopUp
		{
			return viewComponent as InsertImgPopUp;
		}
		
		override public function listNotificationInterests():Array
		{
			return [NotificationConstants.GET_ALL_IMGS_RESULT];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case NotificationConstants.GET_ALL_IMGS_RESULT:
					view.imgArray = new ArrayCollection( note.getBody() as Array );
					if( view.imgArray.length > 0 ) {
						view.comboBox.selectedIndex = 0;
						view.loading.visible = true;
						view.preview.source = 'http://174.122.24.74/amf/services/autor2/mediafiles/'+MediaVO(view.imgArray.getItemAt( view.comboBox.selectedIndex )).body;
						view.preview.addEventListener(Event.COMPLETE, function(e:Event):void {view.loading.visible=false});
						view.currentState = "preview";
					}
					else {
						view.comboBox.prompt = "Nenhuma imagem encontrada";
					}
					view.comboBox.enabled = true;
					break;
				default:
					break;
			}
		}
		
		private function insertHandler(e:MouseEvent):void {
			var obj:Object = new Object();
			obj.source = view.preview.source;
			obj.align = view.radioButtonGroup.selectedValue;
			sendNotification(NotificationConstants.INSERT_IMG, obj);
			closeMe();
		}
		
		private function closeMe(e:Event=null):void {
			AutorFacade(facade).dispose( view );
		}
		
		private function comboHandler(e:ListEvent):void {
			view.loading.visible = true;
			view.preview.source = 'http://174.122.24.74/amf/services/autor2/mediafiles/'+MediaVO(view.imgArray.getItemAt( view.comboBox.selectedIndex )).body;
			view.preview.addEventListener(FlexEvent.UPDATE_COMPLETE, function(e:FlexEvent):void {view.loading.visible=false});
			view.currentState = "preview";
		}
	}
}