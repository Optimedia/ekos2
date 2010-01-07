package br.com.optimedia.assets.vo.userdetails
{
	[Bindable] [RemoteClass(alias="br.com.optimedia.assets.vo.userdetails.LanguageVO")]
	
	// LANGUAGE DETAILS
	public class LanguageVO
	{
		public var language_name:String;
		public var speech:int;
		public var writing:int;
		public var reading:int;
	}
}