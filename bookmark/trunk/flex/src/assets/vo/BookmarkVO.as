package assets.vo
{
	[Bindable] [RemoteClass(alias="bookmark.vo.BookmarkVO")]
	public class BookmarkVO
	{
		public var bookmark_id:int;
		public var title:String;
		public var url:String;
		public var creation_date:String;
		public var tags:String;
		public var description:String;

	}
}  