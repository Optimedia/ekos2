package br.com.optimedia.autor.assets.vo
{
	[Bindable] [RemoteClass(alias="br.com.optimedia.assets.vo.MediaVO")]
	
	public class MediaVO
	{
		public var media_id:uint;
		public var category_id:uint;
		public var title:String;
		public var description:String;
		public var creation:String;
		public var last_change:String;
		public var body:String;
		public var status:uint;
		
		public function clone():* {
			var copier:ByteArray = new ByteArray();
			copier.writeObject(this);
			copier.position = 0;
			return copier.readObject() as MediaVO;
		}
	}
}