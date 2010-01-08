package br.com.optimedia.notifyme.controller
{
	import br.com.optimedia.notifyme.model.vo.NotificationVO;
	
	public class GotoFirstCommand extends BaseGotoCommand {
		override public function executeGoto(vo:NotificationVO):void {
			this.notifymeProxy.gotoFirst();
		}
	}
}