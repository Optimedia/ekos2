package br.com.optimedia.notifyme.controller
{
	import br.com.optimedia.notifyme.model.vo.NotificationVO;
	
	public class GotoPriorCommand extends BaseGotoCommand {
		override public function executeGoto(vo:NotificationVO):void {
			if (!vo.isFirst) {
				this.notifymeProxy.gotoPrior();
			}
		}
	}
}