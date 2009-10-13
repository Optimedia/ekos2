package forum.view
{
	import assets.vo.CategoryVO;
	
	import flash.events.MouseEvent;
	
	import forum.model.ForumProxy;
	import forum.view.component.CategoryPopUp;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class CategoryPopUpMediator extends Mediator
	{
		public static const NAME:String = 'CategoryPopUpMediator';
		
		private var proxy:ForumProxy = new ForumProxy();
		
		public var categoryVO:CategoryVO = new CategoryVO();
		
		public function CategoryPopUpMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			proxy = facade.retrieveProxy( ForumProxy.NAME ) as ForumProxy;
			view.saveBtn.addEventListener(MouseEvent.CLICK, onSaveBtnClick);
		}
		
		override public function onRemove():void {
			trace(NAME+".onRemove()");
		}
		
		public function get view():CategoryPopUp
		{
			return viewComponent as CategoryPopUp;
		}
		
		override public function listNotificationInterests():Array
		{
			return [ForumProxy.SAVE_CATEGORY_OK_NOTIFICATION];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case ForumProxy.SAVE_CATEGORY_OK_NOTIFICATION:
					view.close();
					break;
				default:
					break;
			}
		}
		
		private function onSaveBtnClick(event:MouseEvent):void {
			view.updateCategoryVO();
			proxy.saveCategory(view.categoryVO);
		}
	}
}