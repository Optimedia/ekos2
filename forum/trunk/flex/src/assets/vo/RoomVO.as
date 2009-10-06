package assets.vo
{
	
	[Bindable] [RemoteClass(alias="forum.vo.RoomVO")]
	
	public class RoomVO
	{
		public var roomID:int;
		
		public var title:String;
		
		public var description:String;
		
		public var ownerID:int;
	}
}