package br.com.optimedia.xmppfc.view.api.mediators
{
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.interfaces.IMediator;

	public interface IXmppFcMediator extends IMediator
	{
		function doLogin(note:INotification): void;
		function doValidLogin(note:INotification): void;
		function doInvalidLogin(note:INotification): void;
		function doSecurityError(note:INotification): void;
	}
}