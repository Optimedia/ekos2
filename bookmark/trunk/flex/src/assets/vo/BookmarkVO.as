package assets.vo
{
	[Bindable] [RemoteClass(alias="bookmark.vo.BookmarkVO")]
	public class BookmarkVO
	{
		public var bookmarkID:int;
		public var title:String;
		public var url:String;
		public var lastchange:String;
		public var tags:String;
		public var description:String;

	}
}  