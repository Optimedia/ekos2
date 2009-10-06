package assets.vo
{
	//import flash.net.registerClassAlias;
	
	[Bindable] [RemoteClass(alias="forum.UserVO")]
	
	public class UserVO
	{
		public var id:int;
		
		public var avatarLink:String = "../assets/imgs/iron.jpg";
		
		public var numPosts:int;
		
		public var nome:String;
		
		public var sobrenome:String;
		
		public var perfil:String;
		
		public var pais:String;
		
		public var estado:String;
		
		public var cidade:String;
		
		public var dataCadastro:String;
	}
}