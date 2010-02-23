package br.com.optimedia.interactive.model
{
	import br.com.optimedia.interactive.assets.ApplicationConstants;
	import br.com.optimedia.interactive.assets.vo.MediaVO;
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
		
		public var midias:Array;
		public var slidesArray:Array;
		
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
			getSlideResult(slide);
			getLinks(slide.slide_id);
			
		}
		private function getSlideResult(slideVO:SlideVO ):void {
			sendNotification( ApplicationConstants.GET_SLIDE_OK, slideVO );
		}
		
		public function getSlides(presentationID:uint):void {
			var asynkToken:AsyncToken = remoteService.getSlides(1);
			asynkToken.addResponder( new Responder(getSlidesResult, generalFault) );
		}
		private function getSlidesResult(event:ResultEvent ):void {
			
			slidesArray = event.result as Array;
			sendNotification( ApplicationConstants.GET_SLIDES_OK, event.result );
		}
		
		public function getLinks(id:uint):void {
			midias = new Array();
			for (var i:uint=0; i<slidesArray.length ; i++ ) {
				var ids:uint = slidesArray[i].slide_id
				if (slidesArray[i].slide_id==id) {
					for (var j:uint=0; j<slidesArray[i].mediaArray.length; j++) {
						var media:MediaVO = slidesArray[i].mediaArray[j] as MediaVO;
						midias[j] = media;			
					}
				}
			}
			sendNotification(ApplicationConstants.CONTRUCT_LINKS,midias)
				
				
		}
		public function getMidia(id:*):void {
			var id:Number = id as Number;
			for (var i:uint = 0 ; i<midias.length; i++) {
				if (id==midias[i].media_id) {
					var midia:MediaVO = midias[i] as MediaVO;
				}
			}
			sendNotification(ApplicationConstants.OPEN_MIDIA,midia);
		}
	}
}