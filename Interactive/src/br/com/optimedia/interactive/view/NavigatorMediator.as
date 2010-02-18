package br.com.optimedia.interactive.view
{
	import br.com.optimedia.interactive.assets.ApplicationConstants;
	import br.com.optimedia.interactive.view.components.NavigatorView;
	
	import flash.events.MouseEvent;
	
	import mx.core.Application;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class NavigatorMediator extends Mediator {
		
		public static const NAME:String = 'NavigatorMediator';
		
	//	private var interactiveProxy:InteractiveProxy = new InteractiveProxy();
		
		public function NavigatorMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			view.btMenu.addEventListener(MouseEvent.CLICK,showMenu);
			
			//ignoreManagerProxy = facade.retrieveProxy( IgnoreManagerProxy.NAME ) as IgnoreManagerProxy;
		}
		
		override public function onRemove():void {
			trace(NAME+".onRemove()");
		}
		
		public function get view():NavigatorView
		{
			return viewComponent as NavigatorView;
		}
		
		override public function listNotificationInterests():Array
		{
			return [
					//ApplicationConstants.MENU_PAGES, 
					ApplicationConstants.BACK_PAGE, 
					ApplicationConstants.NEXT_PAGE
					
					];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				 //case ApplicationConstants.MENU_PAGES:
						//show( note.getBody() as SlideVO );
					//break; 
				case ApplicationConstants.BACK_PAGE:
						//show( note.getBody() as SlideVO );
					break;  
				case ApplicationConstants.NEXT_PAGE:
						//next_page ( note.getBody() as SlideVO );
					break;
				/*
				case ApplicationConstants.CONTRUCT_MENU:
						constructMenu (note.getBody() as Array);
					break; */
				default:
					break;
			}
		}
		 public function nextPage():void {
		 	
		 }
		 
		 public function showMenu(event:MouseEvent):void {
		 	if (Application.application.menuView.visible==true) {
		 		Application.application.menuView.visible = false;
		 	}else {
		 		Application.application.menuView.visible = true;
		 	}
		 	
		 }
	}
}