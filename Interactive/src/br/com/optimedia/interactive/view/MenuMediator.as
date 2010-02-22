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
					ApplicationConstants.NEXT_PAGE
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
				default:
					break;
			}
		}
		public function itemMenu (event:MouseEvent) :void {
			var vo:SlideVO = view.menuList.selectedItem as SlideVO;
			
			dumbSlide(vo);
		}
		public function constructMenu(slides:Array):void {
			//slidesPresentation=slides; 
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
		 	sendNotification(ApplicationConstants.CLOSE_MIDIA);
		 	
		 	numberTela = view.menuList.selectedIndex + 1;
		 	sendNotification(ApplicationConstants.REMOVE_LINKS)
		 			 	
		 	interactiveProxy = facade.retrieveProxy( InteractiveProxy.NAME ) as InteractiveProxy;
			interactiveProxy.getSlide(vo);
			
		 	var display:Array = new Array (numberTela,totalTela)
		 	sendNotification(ApplicationConstants.PAGE,display);

		 	view.visible=false;
		 }
	}
}