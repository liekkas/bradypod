package org.liekkas.bradypod.controllers.plugins
{
	import flash.events.MouseEvent;
	
	import org.liekkas.bradypod.events.InteractionEvent;
	import org.liekkas.bradypod.views.Topo;
	
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
				topo.addEventListener(InteractionEvent.DRAG_TOPO_START,onStart);
				topo.addEventListener(InteractionEvent.DRAG_TOPO_END,onEnd);
			}
		}
		
		override public function uninstall():void
		{
			if(topo)
			{
				topo.removeEventListener(InteractionEvent.DRAG_TOPO_START,onStart);
				topo.removeEventListener(InteractionEvent.DRAG_TOPO_END,onEnd);
			}
		}
		
		protected function onStart(evt:InteractionEvent):void
		{
			topo.startDrag();
		}
		
		protected function onEnd(evt:InteractionEvent):void
		{
			topo.stopDrag();
		}
	}
}