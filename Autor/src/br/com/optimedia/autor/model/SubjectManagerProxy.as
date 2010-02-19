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
	import mx.controls.Alert;
	import mx.collections.ArrayCollection;

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
		
		public function saveSubject(subjectVO:SubjectVO):void {
			var asynkToken:AsyncToken = remoteService.saveSubject(subjectVO);
			asynkToken.addResponder( new Responder(saveSubjectResult, generalFault) );
		}
		private function saveSubjectResult(event:ResultEvent):void {
			if( event.result == true ) {
				sendNotification( NotificationConstants.SAVE_SUBJECT_OK, event.result );
				getSubjects();
			}
			else Alert.show("Não foi possível salvar, verifique os campos e tente novamente", "Erro");
		}
		
		public function savePresentation(presentationVO:PresentationVO):void {
			var asynkToken:AsyncToken = remoteService.savePresentation(presentationVO);
			asynkToken.addResponder( new Responder(savePresentationResult, generalFault) );
		}
		private function savePresentationResult(event:ResultEvent):void {
			if( event.result == true ) {
				sendNotification( NotificationConstants.SAVE_PRESENTATION_OK, event.result );
				getSubjects();
			}
			else Alert.show("Não foi possível salvar, verifique os campos e tente novamente", "Erro");
		}
		
		private var _presentationSkins:ArrayCollection; 
		public function get presentationSkins():ArrayCollection {
			if(!_presentationSkins) getSkins();
			return _presentationSkins;
		}
		private function getSkins():void {
			var asynkToken:AsyncToken = remoteService.getSkins();
			asynkToken.addResponder( new Responder(getSkinsResult, generalFault) );
		}
		private function getSkinsResult(event:ResultEvent):void {
			if(event.result is Array) _presentationSkins = new ArrayCollection(event.result as Array);
		}
		
		public function deleteSubject(subjectVO:SubjectVO):void {
			var asynkToken:AsyncToken = remoteService.deleteSubject(subjectVO.subject_id);
			asynkToken.addResponder( new Responder(deleteSubjectResult, generalFault) );
		}
		private function deleteSubjectResult(event:ResultEvent):void {
			if( event.result == true ) {
				sendNotification( NotificationConstants.DELETE_SUBJECT_OK );
				getSubjects();
			}
			else Alert.show("Não foi possível excluir, verifique se este módulo não possui temas", "Erro");
		}
		
		public function deletePresentation(presentationVO:PresentationVO):void {
			var asynkToken:AsyncToken = remoteService.deletePresentation(presentationVO.presentation_id);
			asynkToken.addResponder( new Responder(deletePresentationResult, generalFault) );
		}
		private function deletePresentationResult(event:ResultEvent):void {
			if( event.result == true ) {
				sendNotification( NotificationConstants.DELETE_PRESENTATION_OK );
				getSubjects();
			}
			else Alert.show("Não foi possível excluir.", "Erro");
		}
	}
}