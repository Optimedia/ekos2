package br.com.optimedia.assets.vo
{
	[Bindable] [RemoteClass(alias="br.com.optimedia.assets.vo.ContentContainerVO")]
	
	public class ContentContainerVO
	{
		public var id:uint;
		
		public var title:String;
		
		public var description:String;
		
		public var dateCreation:String;
		
		public var lastUpdate:String;
		
		public var tagArray:Array;
		
		public var authorArray:Array;
		
		public var counter:int;
		
		public var rating:int;
	}
}