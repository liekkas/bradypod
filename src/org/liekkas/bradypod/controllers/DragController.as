package org.liekkas.bradypod.controllers
{
	import flash.events.MouseEvent;
	
	import org.liekkas.bradypod.controllers.plugins.DragTopoPlugin;
	import org.liekkas.bradypod.events.InteractionEvent;
	import org.liekkas.bradypod.utils.CursorImage;
	import org.liekkas.bradypod.views.Topo;
	
	/**
	 * 拖拽控制器 -- 拖拽整个拓扑
	 * @author liekkas.zeng
	 * */
	public class DragController extends AbstractController
	{
		public function DragController(topo:Topo=null, active:Boolean=false,cursor:Class = null)
		{
			super(topo, active,cursor?cursor:CursorImage.CURSOR_DRAG);
		}
		
		override protected function register():void
		{
			if(topo)
			{
				installPlugins([new DragTopoPlugin(topo)]);
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
			
			super.unregister();
		}
		
		protected function onMouseDown(evt:MouseEvent):void
		{
			topo.dispatchEvent(new InteractionEvent(InteractionEvent.DRAG_TOPO_START));
		}
		
		protected function onMouseUp(evt:MouseEvent):void
		{
			topo.dispatchEvent(new InteractionEvent(InteractionEvent.DRAG_TOPO_END));
		}
	}
}