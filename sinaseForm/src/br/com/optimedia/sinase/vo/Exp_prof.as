package br.com.optimedia.sinase.vo
{
	
	[Bindable] 
	[RemoteClass(alias="br.com.optimedia.sinase.vo.Exp_prof")]
	
	public class Exp_prof
	{
		public var idexp_prof:uint; 			// int
		public var idtutor:int; 			// int
		public var org_nome:String; 			// String
		public var funcao:String; 			// String
		public var data_ini:String; 			// String
		public var data_fim:String; 			// String
		
		public var _explicitType = "br.com.optimedia.sinase.vo.Exp_prof";
	}
}