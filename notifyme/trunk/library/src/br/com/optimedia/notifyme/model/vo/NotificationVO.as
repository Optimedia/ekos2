package br.com.optimedia.notifyme.model.vo
{
	public class NotificationVO
	{
		// properties
		[Bindable]
		public var id: String;
		
		[Bindable]
		public var source: String;
		
		[Bindable]
		public var title: String;
		
		[Bindable]
		public var timestamp: String;
		
		[Bindable]
		public var description: String;
		
		[Bindable]
		public var url: String;
		
		[Bindable]
		public var isFirst: Boolean;
		
		[Bindable]
		public var isLast: Boolean;
		
		[Bindable]
		public var count: int;
		
		public function NotificationVO(id: String=null, source: String=null, title: String=null, timestamp: String=null, description: String=null, url: String=null, isFirst: Boolean=false, isLast: Boolean=false, count: int=0) {
			this.id = id;
			this.source = source;
			this.title = title;
			this.timestamp = timestamp;
			this.description = description;
			this.url = url;
			this.isFirst = isFirst; 
			this.isLast = isLast;
			this.count = count; 
		}

	}
}