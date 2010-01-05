package br.com.optimedia.xmppfc.view.api.components
{
	import mx.core.IFlexDisplayObject;
	
	public interface IRosterView extends IFlexDisplayObject
	{
		function set enabled(value: Boolean): void;
		function set dataProvider(value:Object): void;
	}
}