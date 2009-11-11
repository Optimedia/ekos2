package br.com.optimedia.assets.vo
{
	[Bindable] [RemoteClass(alias="forum.vo.CategoryVO")]
	
	public class CategoryVO
	{
		public var categoryID:int;
		
		public var name:String;
		
		public var description:String;
		
		public var forumVOArray:Array;
	}
}