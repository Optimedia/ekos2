package br.com.optimedia.assets.vo
{
	[Bindable] [RemoteClass(alias="br.com.optimedia.assets.vo.MessageVO")]
	
	public class MessageVO
	{
		public var message_id:int;
		
		public var sender_profile_id:int;
		
		public var reciver_profile_id:int;
		
		public var sender_status:int;
		
		public var reciver_status:int;
		
		public var send_date:String;
		
		public var subject:String;
		
		public var text:String;
	}
}