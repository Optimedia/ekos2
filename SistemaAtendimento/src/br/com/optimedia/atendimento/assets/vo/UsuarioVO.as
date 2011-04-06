package br.com.optimedia.atendimento.assets.vo
{
	[Bindable] 
	[RemoteClass(alias="br.com.optimedia.atendimento.assets.vo.UsuarioVO")]
	
	public class UsuarioVO{
		public var id_usuario:uint;
		public var nome:String;
		public var email:String;
		public var senha:String;
		public var telefone:String;
		public var celular:String;
		public var cpf:String;
		public var tipoUsuario_id_tipo:uint;
	
	}
}
