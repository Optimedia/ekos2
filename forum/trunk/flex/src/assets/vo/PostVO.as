package assets.vo
{
	[Bindable] [RemoteClass(alias="forum.vo.PostVO")]
	
	public class PostVO
	{
		public var postID:int;
		
		public var name:String;
		
		public var description:String;
		
		public var userID:int;
		
		public var date:String;
		//public var date:Date;
		
		public var topicID:int;
	}
}