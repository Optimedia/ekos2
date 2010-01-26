package br.com.optimedia.ekostalk.view.mediators
{
	import br.com.optimedia.ekostalk.view.components.TalkRosterView;
	import br.com.optimedia.xmppfc.events.ChatEvent;
	import br.com.optimedia.xmppfc.model.XmppfcFacade;
	import br.com.optimedia.xmppfc.model.proxy.XMPPProxy;
	import br.com.optimedia.xmppfc.view.base.mediators.BaseRosterMediator;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.jivesoftware.xiff.core.JID;
	import org.jivesoftware.xiff.data.im.RosterItemVO;
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	public class TalkRosterMediator extends BaseRosterMediator
	{
		public function TalkRosterMediator(viewComponent:Object)
		{
			super(viewComponent);
			ekosrosterView.btnAdd.addEventListener(MouseEvent.CLICK, contactAdd);
			ekosrosterView.btnRemove.addEventListener(MouseEvent.CLICK, contactRemove);
			ekosrosterView.rosterList.addEventListener(MouseEvent.CLICK, onChatClick);
		}
		
		private function get ekosrosterView() : TalkRosterView {
			return viewComponent as TalkRosterView;
		}
		
		override public function onValidLogin(note: INotification): void {
			var xmppProxy:XMPPProxy = facade.retrieveProxy(XMPPProxy.NAME) as XMPPProxy;
			rosterView.enabled = true;
			rosterView.dataProvider = xmppProxy.getRosterDataProvider(); 
		}
		
		public function contactAdd(event: Event): void {
			
			var contactTxt:String = ekosrosterView.textAdd.text;
			if (contactTxt && contactTxt.length > 0) {
				XmppfcFacade.getInstance().addContact(contactTxt); 
				ekosrosterView.textAdd.text = "";
			}			
		}
		public function onChatClick(event: Event):void {
			if (ekosrosterView.rosterList.selectedItem) {
				var jid:JID = new JID(ekosrosterView.rosterList.selectedItem.jid);
				ekosrosterView.dispatchEvent(new ChatEvent(ChatEvent.START_CHAT,jid));
			}
		}
		public function contactRemove(event:Event):void {
			if (this.selectedVO) {
				XmppfcFacade.getInstance().removeContact(this.selectedVO); 
			}
		}
		private function get selectedVO(): RosterItemVO {
			return this.ekosrosterView.rosterList.selectedItem as RosterItemVO;
		}	
	}
}