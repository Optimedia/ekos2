package br.com.optimedia.autor.assets.vo
{
	[Bindable] [RemoteClass(alias="br.com.optimedia.assets.vo.SlideVO")]
	
	public class SlideVO
	{
		public static const TYPE_TITLE:uint = 1;
		public static const TYPE_PAGE:uint = 2;
		
		public var slide_id:uint;
		public var type_slide_id:uint;
		public var presentation_id:uint;
		public var header_id:uint;
		public var page_order:uint;
		public var title:String;
		public var title_menu:String;
		public var text_body:String;
		public var status:uint;
		
		public function clone():* {
			var copier:ByteArray = new ByteArray();
			copier.writeObject(this);
			copier.position = 0;
			return copier.readObject() as SlideVO;
		}
		
	}
}