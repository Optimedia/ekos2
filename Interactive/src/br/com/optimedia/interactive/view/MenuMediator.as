package br.com.optimedia.interactive.view
{
	import br.com.optimedia.interactive.assets.ApplicationConstants;
	import br.com.optimedia.interactive.assets.vo.SlideVO;
	import br.com.optimedia.interactive.model.InteractiveProxy;
	import br.com.optimedia.interactive.view.components.MenuView;
	
	import flash.events.MouseEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class MenuMediator extends Mediator {
		
		public static const NAME:String = "MenuMediator";
		
		private var interactiveProxy:InteractiveProxy;
		
		public function MenuMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			view.menuList.addEventListener(MouseEvent.CLICK,itemMenu);
	
			//ignoreManagerProxy = facade.retrieveProxy( IgnoreManagerProxy.NAME ) as IgnoreManagerProxy;
		}
		
		override public function onRemove():void {
			trace(NAME+".onRemove()");
		}
		
		public function get view():MenuView
		{
			return viewComponent as MenuView;
		}
		
		override public function listNotificationInterests():Array
		{
			return [
					ApplicationConstants.CONTRUCT_MENU
					 ];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case ApplicationConstants.CONTRUCT_MENU:
						constructMenu (note.getBody() as Array);
					break; 
				default:
					break;
			}
		}
		public function itemMenu (event:MouseEvent) :void {
			var vo:SlideVO = view.menuList.selectedItem as SlideVO;
			
			interactiveProxy = facade.retrieveProxy( InteractiveProxy.NAME ) as InteractiveProxy;
			interactiveProxy.getSlide(vo);
			view.visible=false;
		}
		public function constructMenu(slides:Array):void {
		 	view.menuList.dataProvider = slides;
		 	view.visible = false;
		 }
	}
}