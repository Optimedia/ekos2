package br.com.optimedia.atendimento.assets.vo
{
	[Bindable] 
	[RemoteClass(alias="br.com.optimedia.atendimento.assets.vo.AtendimentoVO")]
	
	public class AtendimentoVO
	{

		
		public var id_atendimento:uint;
		public var protocolo:uint;
		public var cliente:String;
		public var email:String;
		public var dt_fila:Date;
		public var dt_inicio:Date;
		public var dt_fim:Date;
		public var atendente_id_atendente:uint;
	
	}
}

