package br.com.optimedia.atendimento.assets.vo
{
	import br.com.flexbrasilia.lib.formatters.MySQLDateFormatter;

	[Bindable] 
	[RemoteClass(alias="br.com.optimedia.atendimento.assets.vo.AtendimentoVO")]
	
	public class AtendimentoVO
	{

		
		public var id_atendimento:uint;
		public var protocolo:String;
		public var cliente:String;
		public var email:String;
		private var _dt_fila:Date;
		private var _dt_inicio:Date;
		private var _dt_fim:Date;
		public var atendente_id_atendente:uint;
	
		public function get dt_fim():Date{
			return _dt_fim;
		}

		public function set dt_fim(value:*):void{
			if (value is Date) {
				_dt_fim = value;
			}else if (value is String){
				_dt_fim = MySQLDateFormatter.mysqlToAs(value as String);
			}
		}

		public function get dt_inicio():Date{
			return _dt_inicio;
		}

		public function set dt_inicio(value:*):void{
			if (value is Date) {
				_dt_inicio = value;
			}else if (value is String){
				_dt_inicio = MySQLDateFormatter.mysqlToAs(value as String);
			}
		}

		public function get dt_fila():Date{
			return _dt_fila;
		}

		public function set dt_fila(value:*):void{
			if (value is Date) {
				_dt_fila = value;
			}else if (value is String){
				_dt_fila = MySQLDateFormatter.mysqlToAs(value as String);
			}
		}

	}
}

