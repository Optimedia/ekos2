package br.com.optimedia.assets.vo
{
	[Bindable] [RemoteClass(alias="br.com.optimedia.assets.vo.EducationVO")]
	
	// EDUCATION DETAILS
	public class EducationVO
	{
		public var detail_education_level_id:uint
		public var institution:String;
		public var year:uint = 1900;
		public var status:uint
		public var course:String;
		public var title:String;
	}
}