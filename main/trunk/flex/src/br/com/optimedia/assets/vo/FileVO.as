package br.com.optimedia.assets.vo
{
	import flash.utils.ByteArray;

	[Bindable] [RemoteClass(alias="br.com.optimedia.assets.vo.FileVO")]
	
	public class FileVO
	{
		public var filename:String;

		public var filedata:ByteArray;
	}
}
