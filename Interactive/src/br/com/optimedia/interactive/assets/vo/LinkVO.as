package br.com.optimedia.interactive.assets.vo
{
	public class LinkVO
	{
		public var media_id:uint;
		public var category_id:uint;
		public var category_title:String;
		
		public var title_id:uint;
		public var title_midia:String;
		
		public var description_midia:String;
		public var body_midia:String;
		public var status_midia:uint;
		
		
		public function LinkVO(media_id:uint = 0, category_id:uint = 0, 
							category_title:String = null, title_id:uint = 0, 
							title_midia:String = null, description_midia:String = null,
							body_midia:String = null, status_midia:uint = 0 )
		{
					this.media_id=media_id;
					this.category_id = category_id;
					this.category_title = category_title;
					this.title_id = title_id;
					this.title_midia = title_midia;
					this.description_midia = description_midia;
					this.body_midia = body_midia;
					this.status_midia = status_midia;
		}

	}
}