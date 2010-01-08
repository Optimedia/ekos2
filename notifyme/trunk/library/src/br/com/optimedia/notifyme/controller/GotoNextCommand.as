package br.com.optimedia.notifyme.controller
{
	import br.com.optimedia.notifyme.model.vo.NotificationVO;
	
	public class GotoNextCommand extends BaseGotoCommand {
		override public function executeGoto(vo:NotificationVO):void {
			if (!vo.isLast) {
				this.notifymeProxy.gotoNext();
			}
		}
	}
}