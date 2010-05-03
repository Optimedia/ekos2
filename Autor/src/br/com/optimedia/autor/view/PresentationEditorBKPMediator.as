package br.com.optimedia.autor.view
{
	import br.com.optimedia.assets.NotificationConstants;
	import br.com.optimedia.assets.vo.MediaVO;
	import br.com.optimedia.assets.vo.PresentationVO;
	import br.com.optimedia.assets.vo.SlideVO;
	import br.com.optimedia.autor.AutorFacade;
	import br.com.optimedia.autor.model.SlideManagerProxy;
	import br.com.optimedia.autor.model.SubjectManagerProxy;
	import br.com.optimedia.autor.view.components.PresentationEditor;
	import br.com.optimedia.autor.view.components.TextEditor;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class PresentationEditorBKPMediator extends Mediator
	{
		public static const NAME:String = 'SlideEditorMediator';
		
		private var proxy:SlideManagerProxy;
		private var subjectManagerProxy:SubjectManagerProxy;
		private var slideManagerProxy:SlideManagerProxy;
		
		public function PresentationEditorBKPMediator(viewComponent:Object=null)
		{
			super(NAME+viewComponent.uid, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			view.backBtn.addEventListener( MouseEvent.CLICK, backBtnClick );
			
			view.addEventListener( PresentationEditor.NEW_SLIDE_EVENT, addNewSlide );
			view.addEventListener( PresentationEditor.SET_SLIDE_ORDER_EVENT, setOrder );
			view.addEventListener( PresentationEditor.DELETE_SLIDE_EVENT, deleteSlide );
			view.addEventListener( PresentationEditor.SAVE_SLIDE_EVENT, saveSlide );
			view.textEditor.addEventListener( TextEditor.SELECT_MEDIA_ON_REPOSITORY_EVENT, selectMediaOnRepository);
			
			proxy = facade.retrieveProxy( SlideManagerProxy.NAME ) as SlideManagerProxy;
			subjectManagerProxy = facade.retrieveProxy( SubjectManagerProxy.NAME ) as SubjectManagerProxy;
			slideManagerProxy = facade.retrieveProxy( SlideManagerProxy.NAME ) as SlideManagerProxy;
			
			view.setRoleID( AutorFacade(facade).userRole );
		}
		
		override public function onRemove():void {
			
		}
		
		public function get view():PresentationEditor
		{
			return viewComponent as PresentationEditor;
		}
		
		override public function listNotificationInterests():Array
		{
			return [NotificationConstants.BEGIN_PRESENTATION_EDIT,
					NotificationConstants.GET_SLIDES_OK,
					NotificationConstants.UNLOCK_PRESENTATION_OK,
					NotificationConstants.ADD_NEW_SLIDE_RESULT,
					NotificationConstants.SET_SLIDE_ORDER_RESULT,
					NotificationConstants.DELETE_SLIDE_RESULT,
					NotificationConstants.SAVE_SLIDE_RESULT,
					NotificationConstants.DO_LINK_EVENT];
		}
		private var orderDirection:String;
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case NotificationConstants.BEGIN_PRESENTATION_EDIT:
					view.presentationVO = PresentationVO( note.getBody() );
					proxy.getSlides( view.presentationVO.presentation_id );
					view.slideSelector.playerModule.visible = false;
					view.slideSelector.setInteractiveVars( view.presentationVO.presentation_id, view.presentationVO.slidesArray[0] );
					view.repositoryPanel.linkBtn.visible = false;
					break;
				case NotificationConstants.GET_SLIDES_OK:
					view.presentationVO.slidesArray = note.getBody() as Array;
					view.slideSelector.presentationVO = view.presentationVO;
					view.slideSelector.playerModule.visible = true;
					if( view.presentationVO.slidesArray.length <= 1 ) {
						view.slideSelector.slideRemoveBtn.enabled = false;
					}
					else {
						view.slideSelector.slideRemoveBtn.enabled = true;
					}
					break;
				case NotificationConstants.UNLOCK_PRESENTATION_OK:
					sendNotification( NotificationConstants.BACK_TO_SUBJECT_MANAGER );
					break;
				case NotificationConstants.ADD_NEW_SLIDE_RESULT:
					view.orderChangeHandler();
					orderDirection = 'plus';
					break;
				case NotificationConstants.SET_SLIDE_ORDER_RESULT:
					view.presentationVO.slidesArray = new ArrayCollection( note.getBody() as Array );
					view.slideSelector.changeSlide(orderDirection);
					break;
				case NotificationConstants.DELETE_SLIDE_RESULT:
					view.orderChangeHandler();
					orderDirection = 'minus'
					break;
				case NotificationConstants.SAVE_SLIDE_RESULT:
					view.closeTextEditor(null);
					break;
				case NotificationConstants.DO_LINK_EVENT:
					if( view.textEditor.beginIndex != view.textEditor.endIndex ) {
						view.textEditor.currentMediaID = MediaVO( note.getBody() ).media_id;
						view.textEditor.makeLink();
					}
					else {
						Alert.show("É necessário selecionar um texto antes.", "Atenção");
					}
					break;
				default:
					break;
			}
		}
		
		private function backBtnClick(event:MouseEvent):void {
			subjectManagerProxy.unlockPresentation( view.presentationVO.presentation_id );
			view.viewStack.selectedIndex = 0;
		}
		
		private function addNewSlide(event:ResultEvent):void {
			slideManagerProxy.addNewSlide( event.result as SlideVO );
		}
		
		private function setOrder(event:ResultEvent):void {
			slideManagerProxy.setOrder( event.result as Array );
		}
		
		private function deleteSlide(event:ResultEvent):void {
			slideManagerProxy.deleteSlide( event.result as SlideVO );
		}
		
		private function saveSlide(event:ResultEvent):void {
			slideManagerProxy.saveSlide( event.result as SlideVO );
		}
		
		private function selectMediaOnRepository(event:ResultEvent):void {
			for each( var item:Object in view.repositoryPanel.mediaTree.dataProvider ) {
				for each( var media:MediaVO in item.children ) {
					if( media.media_id.toString() == event.result as String ) {
						view.repositoryPanel.mediaTree.selectedItem = media;
						view.repositoryPanel.treeItemClick(null);
						return;
					}
				}
			}
		}
	}
}