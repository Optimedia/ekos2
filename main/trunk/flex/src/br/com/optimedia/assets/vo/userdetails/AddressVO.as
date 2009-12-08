package br.com.optimedia.assets.vo.userdetails
{
	[Bindable] [RemoteClass(alias="br.com.optimedia.assets.vo.userdetails.AddressVO")]
	
	// ADDRESS DETAILS
	public class AddressVO
	{
		public var addressType:String;
		public var addressCountry:String;
		public var addressUF:String;
		public var addressCity:String;
		public var address:String;
		public var addressComplement:String;
		public var zipCode:String;
	}
}