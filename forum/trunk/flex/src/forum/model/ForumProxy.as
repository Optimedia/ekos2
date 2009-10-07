package forum.model
{
	import assets.vo.CategoryVO;
	
	import mx.controls.Alert;
	import mx.managers.CursorManager;
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class ForumProxy extends Proxy
	{
		public static const NAME:String = "ForumProxy";
		
		//public static const USER_DATA_RESULT_NOTIFICATION:String = "USER_DATA_RESULT_NOTIFICATION";
		
		private var remoteService:RemoteObject;
		
		//private var userVO:UserVO;
		
		public function ForumProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void {
			trace(NAME+".onRegister()");
			remoteService = new RemoteObject();
			remoteService.destination = "amfphp";
			remoteService.source = "forum.ForumService";
			remoteService.showBusyCursor = true;
			remoteService.addEventListener(FaultEvent.FAULT, generalFault);
		}
		
		private function generalFault(event:FaultEvent):void {
			Alert.show(event.fault.faultCode as String);
		}
		
		public function saveCategory(categoryVO:CategoryVO):void {
			var asynkToken:AsyncToken = remoteService.saveCategory(categoryVO);
			asynkToken.addResponder( new Responder(saveCategoryResult, generalFault) );
		}
		
		private function saveCategoryResult(event:ResultEvent):void {
			trace(NAME+".saveCategoryResult() = "+event.result);
		}
	}
}