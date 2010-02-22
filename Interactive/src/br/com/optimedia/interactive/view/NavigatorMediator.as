package br.com.optimedia.interactive.view
{
	import br.com.optimedia.interactive.assets.ApplicationConstants;
	import br.com.optimedia.interactive.assets.vo.LinkVO;
	import br.com.optimedia.interactive.view.components.NavigatorView;
	
	import flash.events.MouseEvent;
	
	import mx.controls.Button;
	import mx.core.Application;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class NavigatorMediator extends Mediator {
		
		public static const NAME:String = 'NavigatorMediator';
		
		public var btn:Button;
		public var links:Array;
		
		
	//	private var interactiveProxy:InteractiveProxy = new InteractiveProxy();
		
		public function NavigatorMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			view.btMenu.addEventListener(MouseEvent.CLICK,showMenu);
			view.btNext.addEventListener(MouseEvent.CLICK,nextPage);
			view.btBack.addEventListener(MouseEvent.CLICK,backPage);
			
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
					ApplicationConstants.PAGE,
					ApplicationConstants.CONTRUCT_LINKS,
					ApplicationConstants.REMOVE_LINKS
				//	ApplicationConstants.BACK_PAGE, 
					];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				
				case ApplicationConstants.PAGE:
						display (note.getBody() as Array);
					break;
				case ApplicationConstants.CONTRUCT_LINKS:
						constructionLink (note.getBody() as Array);
					break;
				case ApplicationConstants.REMOVE_LINKS:
						removeMidia ();
					break;	
				default:
					break;
			}
		}
		 public function nextPage(event:MouseEvent):void {
		 	sendNotification(ApplicationConstants.NEXT_PAGE);
		 	
		 }
		 public function backPage (event:MouseEvent):void {
		 	sendNotification(ApplicationConstants.BACK_PAGE);
		 	
		 }
		 public function showMenu(event:MouseEvent):void {
		 	if (Application.application.menuView.visible==true) {
		 		Application.application.menuView.visible = false;
		 	}else {
		 		Application.application.menuView.visible = true;
		 	}
		 }
		 public function display (note:Array):void {
		 	if (note[0]==1 && note[1]>1) {
		 		view.btBack.visible = false;
		 		view.btNext.visible = true;
		 	}else if (note[0]==1 && note[1]==1) {
		 		view.btBack.visible = false;
		 		view.btNext.visible = false;
		 	}else if (note[0] == note[1]) {
		 		view.btBack.visible = true;
		 		view.btNext.visible = false;
		 	} else {
		 		view.btBack.visible = true;
		 		view.btNext.visible = true;
		 	}
		 	view.display.text = note[0] + " / " +  note[1];
		 }
		 public function constructionLink(note:Array):void {
		 	links = note;
		 	for (var i:int=0 ; i<note.length; i++) {
		 		var link:LinkVO = note[i] as LinkVO;
		 		
		 		btn = new Button();
		 		btn.width = 40;
		 		btn.height = 24;
		 		btn.label = link.category_title;
		 		btn.data = link;
		 		btn.addEventListener(MouseEvent.CLICK,clickLink);
		 		view.links.addChild(btn);
		 	}
		 }
		public function clickLink(event:MouseEvent):void {
		 	var link:LinkVO = event.target.data as LinkVO;
		 	sendNotification(ApplicationConstants.CREAT_MIDIA,link);
		 	
		 }
		 public function removeMidia ():void {
		 	view.links.removeAllChildren();
		 }
		 
	}
}