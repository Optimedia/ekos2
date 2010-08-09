package br.com.optimedia.assets.vo
{
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	
	[Bindable] [RemoteClass(alias="br.com.optimedia.assets.vo.SubjectVO")]
	
	public class SubjectVO
	{
		public var subject_id:uint;
		public var title:String;
		public var description:String;
		public var status:uint;
		private var _presentationArray:ArrayCollection;
		
		public function clone():* {
			var copier:ByteArray = new ByteArray();
			copier.writeObject(this);
			copier.position = 0;
			return copier.readObject() as SubjectVO;
		}
		
		public function set presentationArray(value:*):void {
			if( value is ArrayCollection) _presentationArray = value;
			else _presentationArray = new ArrayCollection( value );
		}
		public function get presentationArray():* {
			return _presentationArray;
		}
	}
}