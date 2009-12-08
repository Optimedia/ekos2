package br.com.optimedia.assets.vo.userdetails
{
	[Bindable] [RemoteClass(alias="br.com.optimedia.assets.vo.userdetails.ProfessionalVO")]
	
	// PROFESSIONAL DETAILS
	public class ProfessionVO
	{
		public var company:String;
		public var position:String;
		public var jobDescription:String;
		public var jobCountry:String;
		public var jobState:String;
		public var jobCity:String;
		public var jobBeginDate:String;
		public var jobEndDate:String;
	}
}