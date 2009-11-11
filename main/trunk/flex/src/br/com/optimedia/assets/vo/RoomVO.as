package br.com.optimedia.assets.vo
{
	[Bindable] [RemoteClass(alias="forum.vo.RoomVO")]
	
	public class RoomVO
	{
		public var roomID:int;
		
		public var name:String;
		
		public var description:String;
		
		public var topicVOArray:Array;
		
		public var forumID:int;
	}
}