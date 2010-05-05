package br.com.flexbrasilia.whiteboard
{
	import br.com.flexbrasilia.whiteboard.tools.DrawingTool;
	
	import flash.events.MouseEvent;
	
	import mx.containers.Canvas;

	public class WhitePaper extends Canvas
	{
		public function WhitePaper()
		{
			super();
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		private var _selectedTool:DrawingTool;
		public function set selectedTool(tool:DrawingTool):void {
			_selectedTool = tool;
		}
		public function get selectedTool():DrawingTool {
			return _selectedTool;
		}
		
		public function onMouseDown(event:MouseEvent):void {
			if( selectedTool ) {
				this.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
				this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				systemManager.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				//this.addEventListener(MouseEvent.MOUSE_OUT, onMouseLeave);
				selectedTool.beginDrawing(event);
			}
		}
		
		public function onMouseMove(event:MouseEvent):void {
				selectedTool.moveDrawing(event);
		}
		
		public function onMouseUp(event:MouseEvent):void {
			this.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			this.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			systemManager.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			//this.removeEventListener(MouseEvent.MOUSE_OUT, onMouseLeave);
			selectedTool.stopDrawing(event);
		}
		
		public function onMouseLeave(event:MouseEvent):void {
			//onMouseUp( event );
			this.removeEventListener(MouseEvent.MOUSE_OUT, onMouseLeave);
			this.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			this.addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
		}
		
		public function onMouseOver(event:MouseEvent):void {
			this.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			this.removeEventListener(MouseEvent.ROLL_OVER, onMouseOver);
		}
	}
}