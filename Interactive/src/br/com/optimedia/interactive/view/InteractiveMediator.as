package br.com.optimedia.interactive.view
{
	import br.com.optimedia.interactive.assets.ApplicationConstants;
	import br.com.optimedia.interactive.model.InteractiveProxy;
	
	import mx.controls.Alert;
	import mx.core.Application;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class InteractiveMediator extends Mediator
	{
		public static const NAME:String = 'InteractiveMediator';
		public var idPresentation:Number;
		
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
			startUp(idPresentation);
			
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
			return [ApplicationConstants.GET_SLIDES_OK];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case ApplicationConstants.GET_SLIDES_OK:
					creatSlides(note.getBody() as Array);
					break; 
				default:
					break;
			}
		}
		public function startUp(presentationID:uint):void {
			interactiveProxy.getSlides(presentationID);
		}
		
		public function creatSlides(slides:Array) :void {
			
			//var slide:SlideVO= slides[0] as SlideVO; 			
			//interactiveProxy = facade.retrieveProxy( InteractiveProxy.NAME ) as InteractiveProxy;
			//interactiveProxy.getSlide(slide);			
			
			sendNotification(ApplicationConstants.CONTRUCT_MENU,slides);
			
			Application.application.navigatorView.visible = true;
			Application.application.slideView.visible = true;
		}
	}
}