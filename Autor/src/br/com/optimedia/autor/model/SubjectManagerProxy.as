package br.com.optimedia.autor.model
{
	import br.com.optimedia.autor.assets.FaultHandler;
	import br.com.optimedia.autor.assets.NotificationConstants;
	import br.com.optimedia.autor.assets.vo.SubjectVO;
	import br.com.optimedia.autor.assets.vo.PresentationVO;
	import br.com.optimedia.autor.assets.vo.SlideVO;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	import br.com.optimedia.autor.assets.vo.CompleteUserVO;

	public class SubjectManagerProxy extends Proxy
	{
		public static const NAME:String = "SubjectManagerProxy";
		
		private var remoteService:RemoteObject;
		
		public function SubjectManagerProxy(data:Object=null)
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
			FaultHandler.handleFault(event);
		}
		
		public function getSubjects():void {
			var asynkToken:AsyncToken = remoteService.getSubjects();
			asynkToken.addResponder( new Responder(getSubjectsResult, generalFault) );
		}
		private function getSubjectsResult(event:ResultEvent):void {
			sendNotification( NotificationConstants.GET_SUBJECTS_OK, event.result );
		}
		
		public function newSubject(subjectVO:SubjectVO):void {
			var asynkToken:AsyncToken = remoteService.newSubject(subjectVO);
			asynkToken.addResponder( new Responder(newSubjectResult, generalFault) );
		}
		private function newSubjectResult(event:ResultEvent):void {
			sendNotification( NotificationConstants.NEW_SUBJECT_OK, event.result );
		}
		
		public function newPresentation(presentationVO:PresentationVO):void {
			var asynkToken:AsyncToken = remoteService.newPresentation(presentationVO);
			asynkToken.addResponder( new Responder(newPresentationResult, generalFault) );
		}
		private function newPresentationResult(event:ResultEvent):void {
			sendNotification( NotificationConstants.NEW_PRESENTATION_OK, event.result );
		}
		
		public function newSlide(slideVO:SlideVO):void {
			var asynkToken:AsyncToken = remoteService.newSlide(slideVO);
			asynkToken.addResponder( new Responder(newSlideResult, generalFault) );
		}
		private function newSlideResult(event:ResultEvent):void {
			sendNotification( NotificationConstants.NEW_SLIDE_OK, event.result );
		}
		
		public function getUser(user:CompleteUserVO):void {
			var asynkToken:AsyncToken = remoteService.getUser(user);
			asynkToken.addResponder( new Responder(getUserResult, generalFault) );
		}
		private function getUserResult(event:ResultEvent):void {
			sendNotification( NotificationConstants.GET_USER_OK, event.result );
		}
	}
}