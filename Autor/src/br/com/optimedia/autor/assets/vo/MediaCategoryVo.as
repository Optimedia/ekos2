package br.com.optimedia.autor.assets.vo
{
	[Bindable] [RemoteClass(alias="br.com.optimedia.assets.vo.MediaCategoryVO")]
	
	public class MediaCategoryVO
	{
		public var category_id:uint;
		public var title:String;
		public var status:uint;
		
		public function clone():* {
			var copier:ByteArray = new ByteArray();
			copier.writeObject(this);
			copier.position = 0;
			return copier.readObject() as MediaVO;
		}
	}
}