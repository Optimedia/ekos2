package br.com.optimedia.autor.model
{
	import br.com.optimedia.autor.assets.FaultHandler;
	import br.com.optimedia.autor.assets.NotificationConstants;
	import br.com.optimedia.autor.assets.vo.FileVO;
	import br.com.optimedia.autor.assets.vo.MediaVO;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class RepositoryManagerProxy extends Proxy
	{
		public static const NAME:String = "RepositoryManagerProxy";
		
		private var remoteService:RemoteObject;
		
		public function RepositoryManagerProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void {
			trace(NAME+".onRegister()");
			remoteService = new RemoteObject();
			remoteService.destination = "amfphp";
			remoteService.source = "autor.RepositoryManager";
			remoteService.showBusyCursor = true;
		}
		
		private function generalFault(event:FaultEvent):void {
			FaultHandler.handleFault(event);
		}
		
		public function getMedias( presentationID:uint ):void {
			/* var asynkToken:AsyncToken = remoteService.getMedias( presentationID );
			asynkToken.addResponder( new Responder(getMediasResult, generalFault) ); */
			var xml:XML = 	<medias>
								<cat name="Tabelas">
			                        <item name="bla1" ref="referencia1" icon="table" id=""/>
			                        <item name="bla2" ref="referencia1" icon="table" id=""/>
			                        <item name="bla3" ref="referencia1" icon="table" id=""/>
			                    </cat>
								<cat name="Gráficos">
			                        <item name="bla1" ref="referencia1" icon="" id=""/>
			                        <item name="bla2" ref="referencia1" icon="" id=""/>
			                        <item name="bla3" ref="referencia1" icon="" id=""/>
			                    </cat>
								<cat name="Imagens">
			                        <item name="bla1" ref="referencia1" icon="" id=""/>
			                        <item name="bla2" ref="referencia1" icon="" id=""/>
			                        <item name="bla3" ref="referencia1" icon="" id=""/>
			                    </cat>
								<cat name="Links">
			                        <item name="bla1" ref="referencia1" icon="" id=""/>
			                        <item name="bla2" ref="referencia1" icon="" id=""/>
			                        <item name="bla3" ref="referencia1" icon="" id=""/>
			                    </cat>
								<cat name="Vídeos">
			                        <item name="bla1" ref="referencia1" icon="" id=""/>
			                        <item name="bla2" ref="referencia1" icon="" id=""/>
			                        <item name="bla3" ref="referencia1" icon="" id=""/>
			                    </cat>
								<cat name="Texto">
			                        <item name="bla1" ref="referencia1" icon="" id=""/>
			                        <item name="bla2" ref="referencia1" icon="" id=""/>
			                        <item name="bla3" ref="referencia1" icon="" id=""/>
			                    </cat>
							</medias>;
			var event:ResultEvent = new ResultEvent(ResultEvent.RESULT, false, true, xml);
			getMediasResult( event );
		}
		private function getMediasResult(event:ResultEvent):void {
			sendNotification( NotificationConstants.GET_MEDIAS_RESULT, event.result );
		}
		
		public function uploadPresentationFile(fileVO:FileVO, presentationID:uint, type:String):void {
			var asynkToken:AsyncToken = remoteService.uploadPresentationFile(fileVO, presentationID, type);
			asynkToken.addResponder( new Responder(uploadPresentationFileResult, generalFault) );
		}
		private function uploadPresentationFileResult(event:ResultEvent):void {
			sendNotification( NotificationConstants.UPLOAD_PRESENTATION_FILE_RESULT, event.result );
		}
		
		public function uploadMediaFile(fileVO:FileVO, mediaVO:MediaVO):void {
			var asynkToken:AsyncToken = remoteService.uploadMediaFile(fileVO, mediaVO);
			asynkToken.addResponder( new Responder(uploadMediaFileResult, generalFault) );
		}
		private function uploadMediaFileResult(event:ResultEvent):void {
			sendNotification( NotificationConstants.UPLOAD_MEDIA_FILE_RESULT, event.result );
		}
		
		public function uploadMediaText(mediaVO:MediaVO):void {
			var asynkToken:AsyncToken = remoteService.uploadMediaText(mediaVO);
			asynkToken.addResponder( new Responder(uploadMediaTextResult, generalFault) );
		}
		private function uploadMediaTextResult(event:ResultEvent):void {
			sendNotification( NotificationConstants.UPLOAD_MEDIA_TEXT_RESULT, event.result );
		}
	}
}