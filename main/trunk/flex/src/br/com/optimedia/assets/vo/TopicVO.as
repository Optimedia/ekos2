package br.com.optimedia.assets.vo
{
	[Bindable] [RemoteClass(alias="br.com.optimedia.assets.vo.TopicVO")]
	
	public class TopicVO
	{
		public var topicID:int;
		
		public var name:String;
		
		public var description:String;
		
		public var roomID:int;
	}
}