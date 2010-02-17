package br.com.optimedia.autor.view
{
	import br.com.optimedia.autor.assets.NotificationConstants;
	import br.com.optimedia.autor.assets.vo.SubjectVO;
	import br.com.optimedia.autor.model.SubjectManagerProxy;
	import br.com.optimedia.autor.view.components.SubjectManager;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import br.com.optimedia.autor.assets.vo.PresentationVO;

	public class SubjectManagerMediator extends Mediator
	{
		public static const NAME:String = 'SubjectManagerMediator';
		
		private var subjectManagerProxy:SubjectManagerProxy;
		
		public function SubjectManagerMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			
			view.addEventListener( SubjectManager.SAVE_SUBJECT_EVENT, saveSubject );
			view.addEventListener( SubjectManager.SAVE_PRESENTATION_EVENT, savePresentation );
			view.addEventListener( SubjectManager.DELETE_SUBJECT_EVENT, deleteSubject );
			view.addEventListener( SubjectManager.DELETE_PRESENTATION_EVENT, deletePresentation );
			
			subjectManagerProxy = facade.retrieveProxy( SubjectManagerProxy.NAME ) as SubjectManagerProxy;
			subjectManagerProxy.getSubjects();
		}
		
		override public function onRemove():void {
			
		}
		
		public function get view():SubjectManager
		{
			return viewComponent as SubjectManager;
		}
		
		override public function listNotificationInterests():Array
		{
			return [NotificationConstants.GET_SUBJECTS_OK,
					NotificationConstants.SAVE_SUBJECT_OK,
					NotificationConstants.SAVE_PRESENTATION_OK];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case NotificationConstants.GET_SUBJECTS_OK:
					view.subjectArray = new ArrayCollection(note.getBody() as Array);
					break;
				case NotificationConstants.SAVE_SUBJECT_OK:
					Alert.show("Módulo salvo com sucesso.", "OK");
					view.newSubjectPopUp.closeMe();
					break;
				case NotificationConstants.SAVE_PRESENTATION_OK:
					Alert.show("Tema salvo com sucesso.", "OK");
					view.newPresentationPopUp.closeMe();
					break;
				default:
					break;
			}
		}
		
		private function saveSubject(event:Event):void {
			subjectManagerProxy.saveSubject( view.newSubjectPopUp.subjectVO );
		}
		
		private function savePresentation(event:Event):void {
			subjectManagerProxy.savePresentation( view.newPresentationPopUp.presentationVO );
		}
		
		private function deleteSubject(event:Event):void {
			subjectManagerProxy.deleteSubject( view.subjectGrid.selectedItem as SubjectVO );
		}
		
		private function deletePresentation(event:Event):void {
			subjectManagerProxy.deletePresentation( view.presentationGrid.selectedItem as PresentationVO );
		}
	}
}