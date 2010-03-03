package br.com.optimedia.interactive.assets.vo
{
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	
	[Bindable] [RemoteClass(alias="br.com.optimedia.assets.vo.SlideVO")]
	
	public class SlideVO
	{
		public static const TYPE_TITLE:uint = 1;
		public static const TYPE_PAGE:uint = 2;
		public static const TYPE_IMG:uint = 3;
		
		public var slide_id:uint;
		public var type_slide_id:uint;
		public var presentation_id:uint;
		public var header_id:uint;
		public var page_order:uint;
		public var title:String;
		private var _title_menu:String;
		public var text_body:String;
		public var status:uint;
		private var _mediaArray:ArrayCollection = new ArrayCollection();
		
		public function clone():* {
			var copier:ByteArray = new ByteArray();
			copier.writeObject(this);
			copier.position = 0;
			return copier.readObject() as SlideVO;
		}
		
		public function set mediaArray(value:*):void {
			if( value is ArrayCollection) _mediaArray = value;
			else _mediaArray = new ArrayCollection( value );
		}
		public function get mediaArray():* {
			return _mediaArray;
		}
		public function get title_menu():String {
			if (this._title_menu=="") {
				return this.title;
			} else {
				return this._title_menu;
			}
		}
		public function set title_menu(value: String): void {
			this._title_menu = value;
		}
	}
}