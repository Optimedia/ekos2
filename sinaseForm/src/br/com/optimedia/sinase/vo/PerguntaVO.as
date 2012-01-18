package br.com.optimedia.sinase.vo
{
	[Bindable] 
	[RemoteClass(alias="br.com.optimedia.sinase.vo.PerguntaVO")]

	public class PerguntaVO
	{
		public var idpergunta:uint;  //int
		public var descricao:String;    //string
		public var resposta:Array;     // array
	}
}