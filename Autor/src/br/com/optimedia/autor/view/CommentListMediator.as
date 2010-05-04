package br.com.optimedia.autor.view
{
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import br.com.optimedia.autor.view.components.CommentList;

	public class CommentListMediator extends Mediator
	{
		public static const NAME:String = 'CommentListMediator';
		
		public function CommentListMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
		}
		
		override public function onRemove():void {
			//view.removePopup();
		}
		
		public function get view():CommentList
		{
			return viewComponent as CommentList;
		}
		
		override public function listNotificationInterests():Array
		{
			return [];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				default:
					break;
			}
		}
	}
}