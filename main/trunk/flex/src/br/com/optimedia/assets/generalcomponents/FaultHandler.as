package br.com.optimedia.assets.generalcomponents
{
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	
	public class FaultHandler
	{
		public static function handleFault(event:FaultEvent):void {
			switch (event.fault.faultCode) {
				case 'Client.Error.MessageSend':
					Alert.show("Não foi possível conectar ao servidor de login.", "Erro");
					break;
				case 'AMFPHP_INEXISTANT_METHOD':
					Alert.show('Método inexistente no servidor', 'Erro');
					break;
				case 'Client.Error.DeliveryInDoubt':
					Alert.show('Erro no código PHP ou de Include', 'Erro');
					break;
				case 'AMFPHP_RUNTIME_ERROR':
					Alert.show('Erro no código PHP', 'Erro');
					break;
					
				default:
					Alert.show(event.fault.faultCode, 'Erro');
					break;
			}
		}
		/* public function FaultHandler()
		{
		}
		 */
	}
}