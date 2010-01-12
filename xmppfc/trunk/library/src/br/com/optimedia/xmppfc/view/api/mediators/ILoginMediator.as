package br.com.optimedia.xmppfc.view.api.mediators
{
	import br.com.optimedia.xmppfc.events.LoginViewEvent;
	import br.com.optimedia.xmppfc.view.api.components.ILoginView;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;

	public interface ILoginMediator extends IMediator
	{
		function get loginView(): ILoginView;
		function doValidLogin(note: INotification): void;
		function doInvalidLogin(note: INotification): void;
		function doDisconnect(note: INotification): void;
		function onConnectClick(loginViewEvent: LoginViewEvent): void;
		function onDisconnectClick(loginViewEvent: LoginViewEvent): void; 
	}
}