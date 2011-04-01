package com.br.optimedia.projetoPlayer.assest.vo
{
	[Bindable] 
	[RemoteClass(alias="br.com.optimedia.projetoPlayer.assets.vo.LoginVO")]
	
	public class LoginVO
	{
		public var id_usuario:uint;
		public var nome:String;
		public var email:String;
		public var senha:String;
		public var permissao:uint;
	
	}
}