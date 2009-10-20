package forum.view
{
	import assets.vo.UserVO;
	
	import forum.model.UserProxy;
	import forum.view.component.AvatarBox;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class AvatarBoxMediator extends Mediator
	{
		public static const NAME:String = 'AvatarBoxMediator';
		private var contador:int = 0;
		
		private var userVO:UserVO;
		
		private var proxy:UserProxy = new UserProxy();
		
		public function AvatarBoxMediator(viewComponent:Object=null)
		{
			contador++;
			super(NAME+contador.toString(), viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+contador.toString()+".onRegister()");
			proxy = facade.retrieveProxy( UserProxy.NAME ) as UserProxy;
			proxy.getUserData(view.userID);
			/* proxy = facade.retrieveProxy(IdaProxy.NAME) as IdaProxy;
			proxy.getDados("ida_modulos"); */
		}
		
		public function get view():AvatarBox
		{
			return viewComponent as AvatarBox;
		}
		
		override public function listNotificationInterests():Array
		{
			return [UserProxy.USER_DATA_RESULT_NOTIFICATION];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case UserProxy.USER_DATA_RESULT_NOTIFICATION:
					view.userVO = note.getBody() as UserVO;
					break;
				default:
					break;
			}
		}
	}
}