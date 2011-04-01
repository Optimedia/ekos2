package com.br.optimedia.projetoPlayer.assest.vo
{
	[Bindable] 
	[RemoteClass(alias="br.com.optimedia.projetoPlayer.assets.vo.UserVO")]
	
	public class UserVO {
		public var id_usuario:uint;
		public var nome:String;
		public var email:String;
		public var senha:String;
		public var tel:String;
		public var celular:String;
		public var pais:String;
		public var estado:String;
		public var cidade:String;
		public var endereco:String;
		public var barrio:String;
		public var complemento:String;
		public var cep:String;
		public var tipo:uint;
		public var status:uint;
		
	}
}