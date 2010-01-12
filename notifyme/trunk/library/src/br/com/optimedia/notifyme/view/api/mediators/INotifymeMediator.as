package br.com.optimedia.notifyme.view.api.mediators
{
	import br.com.optimedia.notifyme.model.vo.NotificationVO;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	
	public interface INotifymeMediator extends IMediator {
		function notify(vo: NotificationVO): void;
	}
}