/*
Simple Command - PureMVC
 */
package br.com.optimedia.xmppfc.controller {
	import br.com.optimedia.xmppfc.XmppfcFacade;
	import br.com.optimedia.xmppfc.model.XMPPProxy;

    
	/**
	 * Login to the XMPP server with the details specified in the LoginViewEvent
	 */
	public class LoginCommand  {
		
		public function execute(user: String, password: String, server: String): void {
			var xmppProxy:XMPPProxy = XmppfcFacade.getInstance().retrieveProxy(XMPPProxy.NAME) as XMPPProxy;
			xmppProxy.connect(user, password, server);
		}
		
	}
}