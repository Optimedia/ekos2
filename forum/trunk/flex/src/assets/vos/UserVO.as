package assets.vos
{
	import flash.net.registerClassAlias;
	
	[RemoteClass(alias="forum.UserVO")];
	
	[Bindable]
	public class UserVO
	{
		public var id:int;
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