package br.com.optimedia.autor.model
{
	import br.com.optimedia.autor.assets.FaultHandler;
	import br.com.optimedia.autor.assets.NotificationConstants;
	import br.com.optimedia.autor.assets.vo.FileVO;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	import mx.rpc.AsyncToken;

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
			                        <item name="bla1" ref="referencia1" icon="table"/>
			                        <item name="bla2" ref="referencia1" icon="table"/>
			                        <item name="bla3" ref="referencia1" icon="table"/>
			                    </cat>
								<cat name="Gráficos">
			                        <item name="bla1" ref="referencia1" icon=""/>
			                        <item name="bla2" ref="referencia1" icon=""/>
			                        <item name="bla3" ref="referencia1" icon=""/>
			                    </cat>
								<cat name="Imagens">
			                        <item name="bla1" ref="referencia1" icon=""/>
			                        <item name="bla2" ref="referencia1" icon=""/>
			                        <item name="bla3" ref="referencia1" icon=""/>
			                    </cat>
								<cat name="Links">
			                        <item name="bla1" ref="referencia1" icon=""/>
			                        <item name="bla2" ref="referencia1" icon=""/>
			                        <item name="bla3" ref="referencia1" icon=""/>
			                    </cat>
								<cat name="Vídeos">
			                        <item name="bla1" ref="referencia1" icon=""/>
			                        <item name="bla2" ref="referencia1" icon=""/>
			                        <item name="bla3" ref="referencia1" icon=""/>
			                    </cat>
							</medias>;
			var event:ResultEvent = new ResultEvent(ResultEvent.RESULT, false, true, xml);
			getMediasResult( event );
		}
		private function getMediasResult(event:ResultEvent):void {
			sendNotification( NotificationConstants.GET_MEDIAS_RESULT, event.result );
		}
		
		public function uploadFile(fileVO:FileVO):void {
			var asynkToken:AsyncToken = remoteService.uploadFile(fileVO);
			asynkToken.addResponder( new Responder(uploadFileResult, generalFault) );
		}
		private function uploadFileResult(event:ResultEvent):void {
			sendNotification( NotificationConstants.FILE_UPLOAD_COMPLETE, event.result );
		}
	}
}