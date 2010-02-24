package br.com.optimedia.autor.model
{
	import br.com.optimedia.autor.assets.FaultHandler;
	import br.com.optimedia.autor.assets.vo.PresentationVO;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	import br.com.optimedia.autor.assets.NotificationConstants;
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import br.com.optimedia.autor.assets.vo.SlideVO;

	public class SlideManagerProxy extends Proxy
	{
		public static const NAME:String = "SlideManagerProxy";
		
		private var remoteService:RemoteObject;
		
		public function SlideManagerProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void {
			trace(NAME+".onRegister()");
			remoteService = new RemoteObject();
			remoteService.destination = "amfphp";
			remoteService.source = "autor.SlideManager";
			remoteService.showBusyCursor = true;
		}
		
		private function generalFault(event:FaultEvent):void {
			FaultHandler.handleFault(event);
		}
		
		public function getSlides(presentationID:uint):void {
			var asynkToken:AsyncToken = remoteService.getSlides(presentationID);
			asynkToken.addResponder( new Responder(getSlidesResult, generalFault) );
		}
		private function getSlidesResult(event:ResultEvent):void {
			if( event.result is Array ) {
				sendNotification( NotificationConstants.GET_SLIDES_OK, event.result );
			}
		}
		
		public function addNewSlide(slideVO:SlideVO):void {
			var asynkToken:AsyncToken = remoteService.saveSlide(slideVO);
			asynkToken.addResponder( new Responder(addNewSlideResult, generalFault) );
		}
		private function addNewSlideResult(event:ResultEvent):void {
			if( event.result is Array ) {
				sendNotification( NotificationConstants.ADD_NEW_SLIDE_RESULT, event.result );
			}
		}
		
		public function setOrder(slideArray:Array):void {
			var asynkToken:AsyncToken = remoteService.setOrder(slideArray);
			asynkToken.addResponder( new Responder(setOrderResult, generalFault) );
		}
		private function setOrderResult(event:ResultEvent):void {
			if( event.result == true ) {
				sendNotification( NotificationConstants.SET_SLIDE_ORDER_RESULT, event.result );
			}
		}
	}
}