package br.com.optimedia.autor.view
{
	import br.com.optimedia.autor.model.SubjectManagerProxy;
	import br.com.optimedia.autor.view.components.SubjectManager;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import br.com.optimedia.autor.assets.NotificationConstants;
	import br.com.optimedia.autor.assets.vo.SubjectVO;
	import mx.collections.ArrayCollection;

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
			return [NotificationConstants.GET_SUBJECTS_OK];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case NotificationConstants.GET_SUBJECTS_OK:
					view.subjectArray = new ArrayCollection(note.getBody() as Array);
					break;
				default:
					break;
			}
		}
	}
}