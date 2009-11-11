package br.com.optimedia.assets.vo
{
	[Bindable] [RemoteClass(alias="forum.vo.UserVO")]
	
	public class UserVO
	{
		public var userID:int;
		
		public var password:String;
		
		public var roleID:int;
		
		public var userName:String;
		
		public var userSurname:String;
		
		public var country:String;
		
		public var state:String;
		
		public var city:String;
		
		public var dateCreation:String;
		
		public var numPosts:String;
		
		public var avatarLink:String;
	}
}