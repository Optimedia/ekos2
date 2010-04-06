package br.com.optimedia.player.view
{
	import br.com.optimedia.assets.NotificationConstants;
	import br.com.optimedia.assets.vo.SlideVO;
	import br.com.optimedia.player.model.PlayerSlideManagerProxy;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class PlayerModuleMediator extends Mediator
	{
		public static const NAME:String = 'PlayerModuleMediator';
		
		private var proxy:PlayerSlideManagerProxy;
		
		//private var slidesArray:ArrayCollection = new ArrayCollection();
		
		public function PlayerModuleMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			
			view.nextBtn.addEventListener(MouseEvent.CLICK, nextBtnClick);
			view.prevBtn.addEventListener(MouseEvent.CLICK, prevBtnClick);
			
			proxy = facade.retrieveProxy( PlayerSlideManagerProxy.NAME ) as PlayerSlideManagerProxy;
			
			if( view.mode == PlayerModule.PLAYER_MODE ) {
				proxy.getPresentation( view.presentationID );
			}
			else if( view.mode == PlayerModule.PREVIEW_MODE ) {
				
			}
		}
		
		override public function onRemove():void {
			
		}
		
		public function get view():PlayerModule
		{
			return viewComponent as PlayerModule;
		}
		
		override public function listNotificationInterests():Array
		{
			return [NotificationConstants.GET_PRESENTATION_FOR_PLAYER];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case NotificationConstants.GET_PRESENTATION_FOR_PLAYER:
					view.slidesArray = new ArrayCollection( note.getBody() as Array );
					if( view.slidesArray.length <= 0 ) {
						Alert.show("Não há slides nesta apresentação");
					}
					else {
						if( view.slideID == 0 ) {
							view.setSlide( view.slidesArray[0] as SlideVO );
						}
						else {
							for each( var slide:SlideVO in view.slidesArray ) {
								if( slide.slide_id == view.slideID ) {
									view.setSlide( slide );
								}
							}
						}
					}
					break;
				default:
					break;
			}
		}
		
		private function nextBtnClick(event:MouseEvent):void {
			var actualSlideIndex:int = getSlideIndex(view.slideID);
			var nextSlideIndex:int = actualSlideIndex+1;
			disableButtons( nextSlideIndex );
			view.setSlide( view.slidesArray[nextSlideIndex] );
		}
		
		private function prevBtnClick(event:MouseEvent):void {
			var actualSlideIndex:int = getSlideIndex(view.slideID);
			var nextSlideIndex:int = actualSlideIndex-1;
			disableButtons( nextSlideIndex );
			view.setSlide( view.slidesArray[nextSlideIndex] );
		}
		
		private function getSlideIndex(slideID:Number):Number {
			for each( var slide:SlideVO in view.slidesArray ) {
				if( slide.slide_id == slideID ) {
					return view.slidesArray.getItemIndex( slide );
				}
			}
			return 0;
		}
		
		private function disableButtons(slideIndex:int):void {
			view.prevBtn.enabled = true;
			view.nextBtn.enabled = true;
			if( slideIndex == 0 ) {
				view.prevBtn.enabled = false;
			}
			else if( slideIndex == view.slidesArray.length-1 ) {
				view.nextBtn.enabled = false;
			}
		}
	}
}