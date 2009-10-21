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
		
		private var userVO:UserVO;
		
		private var proxy:UserProxy = new UserProxy();
		
		public function AvatarBoxMediator( viewComponent:Object=null )
		{
			super(NAME+AvatarBox(viewComponent).uid, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+view.uid+".onRegister()");
			proxy = facade.retrieveProxy( UserProxy.NAME ) as UserProxy;
			proxy.getUserData(view.userID);
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