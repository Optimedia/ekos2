package br.com.optimedia.assets.vo
{
	[Bindable] [RemoteClass(alias="br.com.optimedia.assets.vo.AddressVO")]
	
	// ADDRESS DETAILS
	public class AddressVO
	{
		public var detail_address_type_id:int;
		public var country_name:String;
		public var state_name:String;
		public var city_name:String;
		public var town_name:String;
		public var address_part1:String;
		public var address_part2:String;
		public var zipcode:String;
		
	}
}