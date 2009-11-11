package br.com.optimedia.assets.vo
{
	[Bindable] [RemoteClass(alias="forum.vo.ForumVO")]
	
	public class ForumVO
	{
		public var forumID:int;
		
		public var name:String;
		
		public var description:String;
		
		public var roomVOArray:Array;
		
		public var categoryID:int;
	}
}