package br.com.optimedia.interactive.model
{
	import br.com.optimedia.autor.assets.vo.MediaVO;
	import br.com.optimedia.autor.assets.vo.SlideVO;
	import br.com.optimedia.interactive.assets.ApplicationConstants;
	
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
		public var idSlide:uint;
		
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
		
		public function getSlide(slideID:uint):void {
			var asynkToken:AsyncToken = remoteService.getSlide(slideID);
			asynkToken.addResponder( new Responder(getSlideResult, generalFault) );
		}
		private function getSlideResult(event:ResultEvent):void {
			sendNotification( ApplicationConstants.IGET_SLIDE_OK, event.result as SlideVO );
		}
		
		public function getSlides(idSlideID:uint):void {
			idSlide = idSlideID as uint;
			var asynkToken:AsyncToken = remoteService.getSlide(idSlide);
			asynkToken.addResponder( new Responder(getSlidesResult, generalFault) );
		}
		private function getSlidesResult(event:ResultEvent ):void {
			slidesArray = [event.result];
			sendNotification( ApplicationConstants.IGET_SLIDES_OK, slidesArray );
		}
		
		public function getLinks(slide:SlideVO):void {
			/* midias = new Array();
			for (var i:uint=0; i<slidesArray.length ; i++ ) {
				var ids:uint = slidesArray[i].slide_id
				//if (slidesArray[i].slide_id==id) {
					for (var j:uint=0; j<slidesArray[i].mediaArray.length; j++) {
						var media:MediaVO = slidesArray[i].mediaArray[j] as MediaVO;
						midias[j] = media;			
					}
				//}
			} */
			var i:uint = 0;
			midias = new Array();
			for each(var item:MediaVO in slide.mediaArray) {
				midias[i] = item;
				i++;
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