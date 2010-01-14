package br.com.optimedia.assets.vo
{
	[Bindable] [RemoteClass(alias="br.com.optimedia.assets.vo.MessageVO")]
	
	public class MessageVO
	{
		public var message_id:uint;
		
		public var sender_profile_id:uint;
		
		public var receiver_profile_id:uint;
		
		public var sender_status:int;
		
		public var receiver_status:int;
		
		public var sent_date:String;
		
		public var subject:String;
		
		public var text:String;
	}
}