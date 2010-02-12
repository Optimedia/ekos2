package br.com.optimedia.interactive.model.vo
{
	public class ComplementVO {
		
		[Bindable]
		public var type:String;
		
		[Bindable]
		public var link:String;
		
		public function ComplementVO(type:String = null, link:String = null) {
			this.type = type;
			this.link = link;
		}

	}
}