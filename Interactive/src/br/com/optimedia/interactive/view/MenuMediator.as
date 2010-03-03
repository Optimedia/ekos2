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
		
		public var numberTela:Number = 1;
		public var totalTela:Number
		public var slidesPresentation:Array;
		
		public function MenuMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			view.menuList.addEventListener(MouseEvent.CLICK,itemMenu);
			
			interactiveProxy = facade.retrieveProxy( InteractiveProxy.NAME ) as InteractiveProxy;
	
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
					ApplicationConstants.CONTRUCT_MENU,
					ApplicationConstants.BACK_PAGE, 
					ApplicationConstants.NEXT_PAGE,
					ApplicationConstants.TOGGLE_MENUVIEW_VISIBILITY
					 ];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case ApplicationConstants.CONTRUCT_MENU:
						constructMenu (note.getBody() as Array);
					break;
				case ApplicationConstants.BACK_PAGE:
						backPage();
					break;  
				case ApplicationConstants.NEXT_PAGE:
						nextPage ();
					break; 
				case ApplicationConstants.TOGGLE_MENUVIEW_VISIBILITY:
					toggleVisibility();
					break;
				default:
					break;
			}
		}
		public function itemMenu (event:MouseEvent) :void {
			var vo:SlideVO = view.menuList.selectedItem as SlideVO;
			
			dumbSlide(vo);
		}
		public function constructMenu(slides:Array):void {
			slidesPresentation=slides as Array; 
			totalTela=slides.length;
		 	view.menuList.dataProvider = slides;
		 	
		 	view.menuList.selectedIndex = 0;
		 	var vo:SlideVO = view.menuList.selectedItem as SlideVO;
		 	dumbSlide(vo);
		 	
		 	view.visible = false;
		 }
		 
		 public function backPage ():void {
		 	view.menuList.selectedIndex = view.menuList.selectedIndex-1;
		 	var vo:SlideVO = view.menuList.selectedItem as SlideVO;
		 	dumbSlide(vo);
		 }
		 public function nextPage():void {
		 	view.menuList.selectedIndex = view.menuList.selectedIndex+1;
		 	var vo:SlideVO = view.menuList.selectedItem as SlideVO;
		 	dumbSlide(vo);
		 }
		 public function dumbSlide (vo:SlideVO):void {
			if (interactiveProxy.idSlide>0) {
				for (var i:uint=0;i<slidesPresentation.length; i++) {
					if (interactiveProxy.idSlide == slidesPresentation[i].slide_id) {
						vo= slidesPresentation[i] as SlideVO;
						view.menuList.selectedIndex = i; 	
					}
				}
				interactiveProxy.idSlide=0;
				
			}	
			
		 	sendNotification(ApplicationConstants.CLOSE_MIDIA);
		 	sendNotification(ApplicationConstants.GET_SLIDE_OK,vo);
		 		
		 	numberTela = view.menuList.selectedIndex + 1;
		 	
		 	var display:Array = new Array (numberTela,totalTela)
		 	sendNotification(ApplicationConstants.PAGE,display);

		 	view.visible=false;
		 }
		 private function toggleVisibility():void {
		 	 if( view.visible == true ) {
		 			view.visible = false;
		 	}
		 	else {
		 			view.visible = true;
		 	} 
		 }
	}
}