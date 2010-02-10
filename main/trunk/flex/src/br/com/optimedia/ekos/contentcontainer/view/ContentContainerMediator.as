package br.com.optimedia.ekos.contentcontainer.view
{
	import br.com.optimedia.ekos.contentcontainer.view.components.ContentContainer;
	
	import flash.system.System;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class ContentContainerMediator extends Mediator
	{
		public static const NAME:String = 'ContentContainerMediator';
		
		//private var friendManagerProxy:FriendManagerProxy;
		
		public function ContentContainerMediator(viewComponent:ContentContainer=null)
		{
			super(NAME+viewComponent.uid, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(super.getMediatorName()+".onRegister()");
			//friendManagerProxy = facade.retrieveProxy( FriendManagerProxy.NAME ) as FriendManagerProxy;
		}
		
		override public function onRemove():void {
			trace(super.getMediatorName()+".onRemove()");
			System.gc();
		}
		
		public function get view():ContentContainer
		{
			return viewComponent as ContentContainer;
		}
		
		override public function listNotificationInterests():Array
		{
			return [];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				default:
					break;
			}
		}
	}
}