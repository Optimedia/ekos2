package br.com.optimedia.ekos.shell.model
{
	
	import br.com.optimedia.assets.vo.ContentContainerVO;
	
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class MainAppProxy extends Proxy
	{
		public static const NAME:String = "MainAppProxy";
		
		// NOTIFICATIONS
		public static const CONTENT_ARRAY_NOTIFICATION:String = "CONTENT_ARRAY_NOTIFICATION";
		
		private var remoteService:RemoteObject;
		
		public function MainAppProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void {
			trace(NAME+".onRegister()");
			remoteService = new RemoteObject();
			remoteService.destination = "amfphp";
			remoteService.source = "mainapp.MainAppService";
			remoteService.showBusyCursor = true;
		}
		
		private function generalFault(event:FaultEvent):void {
			Alert.show(event.fault.faultCode as String);
		}
		
		public function retrieveContentArray():void {
			//var asynkToken:AsyncToken = remoteService.retrieveContentArray();
			//asynkToken.addResponder( new Responder(retrieveContentArrayResult, generalFault) );
			
			// CONTEUDO PARA TESTES
			var array:Array;
			var aux:ContentContainerVO = new ContentContainerVO();
			aux.title = 'Título';
			aux.description = 'ajklsdfladhf kjashdf kdskj ashf gak hgadskj fak asd, hads aklsdjf adsf ads';
			aux.rating = 5;
			aux.dateCreation = '09/09/2009';
			aux.lastUpdate = '10/10/2010';
			aux.authorArray = ['author 1', 'author 2'];
			aux.tagArray = ['tag1', 'tag2'];
			aux.counter = 23423;
			var aux2:ContentContainerVO = new ContentContainerVO();
			aux2.title = 'Título 2';
			aux2.description = 'ajklsdfladhf kjashdf kdskj ashf gak hgadskj fak asd, hads aklsdjf adsf adsajklsdfladhf kjashdf kdskj ashf gak hgadskj fak asd, hads aklsdjf adsf adsajklsdfladhf kjashdf kdskj ashf gak hgadskj fak asd, hads aklsdjf adsf adsajklsdfladhf kjashdf kdskj ashf gak hgadskj fak asd, hads aklsdjf adsf adsajklsdfladhf kjashdf kdskj ashf gak hgadskj fak asd, hads aklsdjf adsf adsajklsdfladhf kjashdf kdskj ashf gak hgadskj fak asd, hads aklsdjf adsf adsajklsdfladhf kjashdf kdskj ashf gak hgadskj fak asd, hads aklsdjf adsf ads';
			aux2.rating = 3;
			aux2.dateCreation = '11/11/2011';
			aux2.lastUpdate = '12/12/2012';
			aux2.authorArray = ['author 1', 'author 2', 'author 3'];
			aux2.tagArray = ['tag1'];
			aux2.counter = 223;
			var aux3:ContentContainerVO = new ContentContainerVO();
			aux3.title = 'Título 3';
			aux3.description = 'ajklsdfladhf kjashdf kdskj ashf gak hgadskj fak asd, hads aklsdjf adsf ads';
			aux3.rating = 1;
			aux3.dateCreation = '01/01/2011';
			aux3.lastUpdate = '12/18/2012';
			aux3.authorArray = ['author 1', 'author 2', 'author 1', 'author 2', 'author 3'];
			aux3.tagArray = ['tag1'];
			aux3.counter = 223;
			array = [aux, aux2, aux3];
			
			sendNotification(CONTENT_ARRAY_NOTIFICATION, array);
		}
		private function retrieveContentArrayResult(event:ResultEvent):void {
			trace(NAME+".retrieveContentArrayResult() = "+event.result);
			sendNotification(CONTENT_ARRAY_NOTIFICATION, event.result);
		}
	}
}