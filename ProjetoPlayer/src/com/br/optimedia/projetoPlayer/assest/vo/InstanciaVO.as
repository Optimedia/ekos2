package com.br.optimedia.projetoPlayer.assest.vo
{
	import br.com.flexbrasilia.lib.formatters.MySQLDateFormatter;

	[Bindable] 
	[RemoteClass(alias="br.com.optimedia.projetoPlayer.assets.vo.InstanciaVO")]
	
	public class InstanciaVO
	{
		public var id_instancia:uint;
		public var max_usuarios:uint;
		private var _validade_inicio:Date;
		private var _validade_fim:Date;
		public var status:uint;
		public var titulo:String;
		public var subTitulo:String;
		public var tema_id_tema:uint;
		public var dataInicioMysql:String;
		public var dataFimMysql:String;

		public function get validade_fim():Date
		{
			return _validade_fim;
		}

		public function set validade_fim(value:*):void
		{
			if (value is Date) {
				_validade_fim = value;
			}else if (value is String){
				_validade_fim = MySQLDateFormatter.mysqlToAs(value as String);
			}
		}

		public function get validade_inicio():Date
		{
			return _validade_inicio;
		}

		public function set validade_inicio(value:*):void
		{
			if (value is Date) {
				_validade_inicio = value;
			}else if (value is String){
				_validade_inicio = MySQLDateFormatter.mysqlToAs(value as String);
			}
		}

	}
}