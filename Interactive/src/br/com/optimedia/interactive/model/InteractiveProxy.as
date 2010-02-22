package br.com.optimedia.interactive.model
{
	import br.com.optimedia.interactive.assets.ApplicationConstants;
	import br.com.optimedia.interactive.assets.vo.LinkVO;
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
		
		public var links:Array;
		
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
			var asynkToken:AsyncToken = remoteService.getSlides(presentationID);
			asynkToken.addResponder( new Responder(getSlidesResult, generalFault) );
		}
		private function getSlidesResult(event:ResultEvent ):void {
			sendNotification( ApplicationConstants.GET_SLIDES_OK, event.result );
		}
		public function getLinks(id:uint):void {
			var link1:LinkVO = new LinkVO();
			link1.media_id = 1;
			link1.category_id = 6;
			link1.category_title= "Text";
			link1.title_id = 1;
			link1.title_midia = "";
			link1.description_midia = "";
			link1.body_midia = "description_midia";
			link1.status_midia = 1;
			
			var link2:LinkVO = new LinkVO();
			link2.media_id = 2;
			link2.category_id = 3;
			link2.category_title= "Chart";
			link2.title_id = 1;
			link2.title_midia = "titulo midia";
			link2.description_midia = "http://www.carrosnitrados.net/";
			link2.body_midia = "blog/wp-content/uploads/2008/04/carros.jpg";
			link2.status_midia = 1;
			
			var link3:LinkVO = new LinkVO();
			link3.media_id = 3;
			link3.category_id = 5;
			link3.category_title= "link";
			link3.title_id = 1;
			link3.title_midia = "titulo midia";
			link3.description_midia = "";
			link3.body_midia = "http://www.uol.com.br";
			link3.status_midia = 1;
			
			links = [link1, link2, link3];
			
			
			sendNotification(ApplicationConstants.CONTRUCT_LINKS,links)			
		}
		public function getMidia(id:*):void {
			var id:Number = id as Number;
			for (var i:uint = 0 ; i<links.length; i++) {
				if (id==links[i].media_id) {
					var midia:LinkVO = links[i] as LinkVO;
				}
			}
			sendNotification(ApplicationConstants.OPEN_MIDIA,midia);
		}
	}
}