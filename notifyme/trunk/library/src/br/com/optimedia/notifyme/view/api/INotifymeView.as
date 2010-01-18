package br.com.optimedia.notifyme.view.api
{
	import br.com.optimedia.notifyme.model.vo.NotificationVO;
	
	public interface INotifymeView {
		function setNotificationVO(vo: NotificationVO): void;
		function getNotificationVO(): NotificationVO;
		function notify(vo: NotificationVO): void;
	}
}