package org.davekeen.xiffer.events {
	import flash.events.Event;
	
	/**
	* Events passed between the login view component and its mediator
	* 
	* @author Dave Keen
	*/
	public class LoginViewEvent extends Event {
		
		public static const REGISTER:String = "login_view_";
		public static const LOGIN:String = "login_view_login";
		public static const LOGOUT:String = "login_view_logout";
		
		private var username:String;
		private var password:String;
		private var server:String;
		
		public function LoginViewEvent(type:String, username:String = null, password:String = null, server:String = null, bubbles:Boolean = false, cancelable:Boolean = false) { 
			super(type, bubbles, cancelable);
			
			this.username = username;
			this.password = password;
			this.server = server;
		}
		
		public function getUsername():String {
			return username;
		}
		
		public function getPassword():String {
			return password;
		}
		
		public function getServer():String {
			return server;
		}
		
		public override function clone():Event { 
			return new LoginViewEvent(type, username, password, server, bubbles, cancelable);
		}
		
	}
	
}