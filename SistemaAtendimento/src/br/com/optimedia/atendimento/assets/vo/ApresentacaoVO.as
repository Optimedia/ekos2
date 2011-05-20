package br.com.optimedia.atendimento.assets.vo
{
	import br.com.flexbrasilia.lib.formatters.MySQLDateFormatter;

	[Bindable] 
	[RemoteClass(alias="br.com.optimedia.atendimento.assets.vo.ApresentacaoVO")]
	
	public class ApresentacaoVO
	{
		
		public var id_apresentacao:uint;
		public var titulo:String;
		public var nomeArquivo:String;
		public var descricao:String;
		private var _data:Date;
		public var tipoApresentacao:uint;
		public var tipo:uint;
		public var frame:uint;
	
		public function get dt_fim():Date{
			return _data;
		}

		public function set data(value:*):void{
			if (value is Date) {
				_data = value;
			}else if (value is String){
				_data = MySQLDateFormatter.mysqlToAs(value as String);
			}
		}
	}
}

