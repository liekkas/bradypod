package org.liekkas.bradypod.controllers
{
	import flash.events.MouseEvent;
	
	import org.liekkas.bradypod.utils.CursorImage;
	import org.liekkas.bradypod.views.Topo;
	
	/**
	 * 拖拽控制器
	 * @author liekkas.zeng
	 * @date 2011-11-29 09:18:25
	 * */
	public class DragController extends BaseController
	{
		public function DragController(topo:Topo=null, active:Boolean=false,cursor:Class = null)
		{
			super(topo, active,cursor?cursor:CursorImage.CURSOR_DRAG);
		}
		
		override protected function register():void
		{
			if(topo)
			{
				topo.graphLayer.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
				topo.graphLayer.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			}
		}
		
		override protected function unregister():void
		{
			if(topo)
			{
				topo.graphLayer.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
				topo.graphLayer.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			}
		}
		
		protected function onMouseDown(evt:MouseEvent):void
		{
			topo.graphLayer.startDrag();
		}
		
		protected function onMouseUp(evt:MouseEvent):void
		{
			topo.graphLayer.stopDrag();
		}
	}
}