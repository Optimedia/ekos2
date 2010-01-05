package br.com.optimedia.xmppfc.model {
	import br.com.optimedia.xmppfc.view.components_old.LoginForm;
	import br.com.optimedia.xmppfc.view.components_old.PresenceNotificationWindow;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import mx.controls.Alert;
	
	import org.jivesoftware.xiff.core.XMPPSocketConnection;
	import org.jivesoftware.xiff.events.*;
	
	public class XmppFlashClient
	{
		// Atributos
		private var xmppConnection:XMPPSocketConnection;
		private var parent:DisplayObject;
		private var loginForm:LoginForm;

		// Propriedades
		private var _showLoginForm:Boolean = true;
		private var _username:String;
		private var _password:String;
		private var _port:Number;
		private var _server:String;
		private var _useAnonymousLogin:Boolean = false;
		
		// Construtores
		public function XmppFlashClient(parent:DisplayObject)
		{
    		this.xmppConnection = new XMPPSocketConnection();
    		this.xmppConnection.addEventListener(XIFFErrorEvent.XIFF_ERROR,                     onError);
    		this.xmppConnection.addEventListener(ConnectionSuccessEvent.CONNECT_SUCCESS,        onConnection);
    		this.xmppConnection.addEventListener(DisconnectionEvent.DISCONNECT,                 onDisconnection);
    		this.xmppConnection.addEventListener(LoginEvent.LOGIN,                              onLogin);
    		this.xmppConnection.addEventListener(PresenceEvent.PRESENCE,                        onPresence);
    		this.xmppConnection.addEventListener(IncomingDataEvent.INCOMING_DATA,               onIncomingData);
    		this.xmppConnection.addEventListener(OutgoingDataEvent.OUTGOING_DATA,               onOutgoingData);
    		this.xmppConnection.addEventListener(MessageEvent.MESSAGE,                          onMessage);
    		this.xmppConnection.addEventListener(ChangePasswordSuccessEvent.PASSWORD_SUCCESS,   onChangePasswordSuccess);
    		this.xmppConnection.addEventListener(RegistrationSuccessEvent.REGISTRATION_SUCCESS, onRegistrationSuccess);
			this.parent = parent;
		}
		
		// Acessores
		public function get showLoginForm(): Boolean { 
			return this._showLoginForm;
		}

		public function get port():Number {
			return this._port;
		}

		public function get server():String {
			return this._server;
		}

		public function get useAnonymousLogin():Boolean {
			return this._useAnonymousLogin;
		}
		
		public function set showLoginForm(value:Boolean): void { 
			this._showLoginForm = value;
		}

		public function set username(value:String): void { 
			this._username = value;
		}

		public function set password(value:String): void { 
			this._password = value;
		}

		public function set port(value:Number): void { 
			this._port = value;
		}

		public function set server(value:String): void { 
			this._server = value;
		}

		public function set useAnonymousLogin(value:Boolean): void { 
			this._useAnonymousLogin = value;
		}
		
		public function isActive(): Boolean {
			return xmppConnection.isActive();
		}
		public function isLoggedIn(): Boolean {
			return xmppConnection.isLoggedIn();
		}
		
		// Métodos
		public function connect(): void {
			if (showLoginForm) {
				this.loginForm = new LoginForm();
				this.loginForm.addEventListener(LoginForm.ON_LOGIN_SUCESS, onSucess);
				this.loginForm.server = this._server;
				this.loginForm.showModal(); 
			} else {
				doConnect()
			}
		}
		
		private function doHideLoginForm():void {
			this.loginForm.hideModal();
		}
		
		private function doConnect(): void {
			if (!this._username) throw new Error("Usuário não informado.");
			if (!this._password) throw new Error("Senha não informada.");
			if (!this._server) throw new Error("Servidor não informado.");
			xmppConnection.username = this._username;
			xmppConnection.password = this._password;
			//xmppConnection.port = port;
			xmppConnection.server = this._server;
			xmppConnection.useAnonymousLogin = this._useAnonymousLogin;
			xmppConnection.connect("standard");
		}
		
		
		// Events handlers 
		private function onSucess(e:Event):void {
			this._username = loginForm.txtUser.text;
			this._password = loginForm.txtPassword.text;
			this._server = loginForm.txtServer.text;
			doConnect();
		}
		
		private function onError(e:XIFFErrorEvent):void {
			trace("onError( code:" + e.errorCode + ", type:" + e.errorType + ", condition:" + e.errorCondition + ", message:" + e.errorMessage + ")");
			this.loginForm.unwait();
			switch (e.errorType) {
			}
			switch (e.errorCode) {
				case 503:
					var errorMsg:String = e.errorMessage;
					if (!xmppConnection.isActive()) {
						errorMsg = "Error trying connect, verify server address."; 
					}
					if ( (this.showLoginForm) && (!xmppConnection.isLoggedIn()) ) {
						this.loginForm.messageError = errorMsg;
					} else {
						throw new Error(errorMsg);
					}
					break;
				case 401:
					if (this.showLoginForm) {
						this.loginForm.messageError = e.errorMessage;
					} else {
						throw new Error(e.errorMessage);
					}
					break;
				case 400:
				case 500:
					Alert.show(e.errorMessage);
					break;
    			default:
					throw new Error(e.errorMessage);
			}
		}

		private function onConnection(e:ConnectionSuccessEvent):void {
   			trace("onConnection " + this.xmppConnection.isLoggedIn());
		}

		private function onDisconnection(e:DisconnectionEvent):void {
			trace("onDisconnection");
		}

		private function onLogin(e:LoginEvent):void {
			trace("onLogin " + this.xmppConnection.isLoggedIn());
			this.xmppConnection.getRegistrationFields();
			this.loginForm.unwait();
			if (this.showLoginForm) {
				this.doHideLoginForm();
			}
		}

		private function onPresence(e:PresenceEvent):void {
			var pnw: PresenceNotificationWindow = new PresenceNotificationWindow();
			trace("onPresence(" + e.data + ")");
		}

		private function onIncomingData(e:IncomingDataEvent):void {
			trace("onIncomingData(" + e.data + ")");
		}

		private function onOutgoingData(e:OutgoingDataEvent):void {
			trace("onOutgoingData(" + e.data + ")");
		}

		private function onMessage(e:MessageEvent):void {
			trace("onMessage(" + e.data + ")");
		}

		private function onChangePasswordSuccess(e:ChangePasswordSuccessEvent):void {
			trace("onChangePasswordSuccess");
		}

		private function onRegistrationSuccess(e:RegistrationSuccessEvent):void {
			trace("onRegistrationSuccess");
		}
		
	}
	
}