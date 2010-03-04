package br.com.optimedia.interactive.view
{
	import br.com.optimedia.interactive.assets.ApplicationConstants;
	import br.com.optimedia.interactive.model.InteractiveProxy;
	
	import flash.events.Event;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class InteractiveMediator extends Mediator
	{
		public static const NAME:String = 'InteractiveMediator';
		public var idPresentation:uint;
		public var idSlide:uint;
		
		private var interactiveProxy:InteractiveProxy;
		
		public function InteractiveMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			interactiveProxy = facade.retrieveProxy( InteractiveProxy.NAME ) as InteractiveProxy;
			//interactiveProxy.getSlide();
			idPresentation = view.idPresentation;
			startUp();
			view.addEventListener( Interactive.GET_SLIDE_EVENT, getSlide );
			
			//ignoreManagerProxy = facade.retrieveProxy( IgnoreManagerProxy.NAME ) as IgnoreManagerProxy;
		}
		
		override public function onRemove():void {
			trace(NAME+".onRemove()");
		}
		
		public function get view():Interactive
		{
			return viewComponent as Interactive;
		}
		
		override public function listNotificationInterests():Array
		{
			return [
					ApplicationConstants.IGET_SLIDES_OK,
					ApplicationConstants.OPEN_MIDIA_VIEW
					];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case ApplicationConstants.IGET_SLIDES_OK:
					creatSlides(note.getBody() as Array);
					break;
				case ApplicationConstants.OPEN_MIDIA_VIEW:
					openMidia(note.getBody() as uint);
					break;
				default:
					break;
			}
		}
		public function startUp():void {
			interactiveProxy.getSlides(view.idSlide);
		}
		
		public function creatSlides(slides:Array):void {		
			sendNotification(ApplicationConstants.CONTRUCT_MENU,slides);
			
			view.navigatorView.visible = true;
			view.slideView.visible = true;
		}
		public function openMidia(tipo:uint):void {
			if (tipo!=5) {
				view.midiaViewObj.visible = true;
			}
		}
		private function getSlide(event:Event):void {
			interactiveProxy.getSlide( view.idSlide );
		}
	}
}