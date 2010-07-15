package br.com.optimedia.idm.vo {
	
	[RemoteClass(alias="br.com.optimedia.idm.vo.UserVO")]
	
	[Bindable]
	public class UserVO {
		public var user_id:uint;
		
		public var node:String;
		public var nome:String;
		public var sobrenome:String;
		public var email:String;
		public var nascimento:String;
		public var login:String;
		public var senha:String;
		public var senha2:String;
		public var pais:String;
		public var cep:String;
		public var uf:*;
		public var municipio:*;
		public var bairro:*;
		public var endereco:*;
		public var complemento:*;
		public var numero:*;
		
		public var ativado:*;
	}
}