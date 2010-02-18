package br.com.optimedia.interactive.model
{
	import br.com.optimedia.interactive.assets.ApplicationConstants;
	import br.com.optimedia.interactive.assets.vo.SlideVO;
	
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class InteractiveProxy extends Proxy
	{
		public static const NAME:String = "InteractiveProxy";
		
		private var remoteService:RemoteObject;
		
		public function InteractiveProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void {
			trace(NAME+".onRegister()");
			remoteService = new RemoteObject();
			remoteService.destination = "amfphp";
			remoteService.source = "autor.SubjectManager";
			remoteService.showBusyCursor = true;
		}
		
		private function generalFault(event:FaultEvent):void {
			Alert.show(event.fault.message, " Proxy erro");
		}
		
		public function getSlide(slide:SlideVO):void {
			/* var asynkToken:AsyncToken = remoteService.getSlide();
			asynkToken.addResponder( new Responder(getSlideResult, generalFault) ); */
			/*
			var slideVO:SlideVO = new SlideVO();
			slideVO.slide_id = 1;
			slideVO.type_slide_id = SlideVO.TYPE_TITLE;
			slideVO.title = "titulo";
			slideVO.text_body = "texto";
			*/
			getSlideResult(slide);
		}
		private function getSlideResult(slideVO:SlideVO ):void {
			sendNotification( ApplicationConstants.GET_SLIDE_OK, slideVO );
		}
		
		public function getSlides(presentationID:uint):void {
			var asynkToken:AsyncToken = remoteService.getSlides(presentationID);
			asynkToken.addResponder( new Responder(getSlidesResult, generalFault) );
		}
		private function getSlidesResult(event:ResultEvent ):void {
			sendNotification( ApplicationConstants.GET_SLIDES_OK, event.result );
		}
	}
}