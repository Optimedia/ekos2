package br.com.optimedia.sinase.selecaoaluno.vo {
	import mx.messaging.management.Attribute;
	
	
	[RemoteClass(alias="br.com.optimedia.sinase.vo.FilterVO")] 
	
	[Bindable]
	
	public class FilterVO {
		
		public var name:String;
		
		public var uf:Array;
		public var atuacao:Array;
		public var bandalarga:int;
		public var atuaorg:Array;
		public var uteis:Array;
		public var fds:Array;
		
		public var moodle:int;
		public var selecionado:int;
		
	}
	
}