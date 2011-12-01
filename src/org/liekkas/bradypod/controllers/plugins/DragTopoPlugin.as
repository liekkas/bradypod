package org.liekkas.bradypod.controllers.plugins
{
	import org.liekkas.bradypod.views.Topo;
	import flash.events.MouseEvent;
	
	/**
	 * 拖拽整个拓扑插件
	 * @author liekkas.zeng
	 * */
	public class DragTopoPlugin extends AbstractPlugin
	{
		public function DragTopoPlugin(topo:Topo)
		{
			super(topo);
		}
		
		override public function install():void
		{
			if(topo)
			{
				topo.graphLayer.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
				topo.graphLayer.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			}
		}
		
		override public function uninstall():void
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