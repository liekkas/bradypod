package org.liekkas.bradypod.controllers
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import org.liekkas.bradypod.controllers.plugins.SelectNodePlugin;
	import org.liekkas.bradypod.events.InteractionEvent;
	import org.liekkas.bradypod.models.Node;
	import org.liekkas.bradypod.views.Topo;
	
	/**
	 * 默认控制器
	 * @author liekkas.zeng
	 * */
	public class DefaultController extends AbstractController
	{
		/**
		 * 鼠标按下的位置
		 * */
		protected var downPoint:Point;
		
		/**
		 * 鼠标click标志 --有时在mouse_down和mouse_up后不希望还有click事件，可以在mouse_move里设为false不让click
		 * */
		protected var allowClick:Boolean = true;
		
		/**
		 * 鼠标按下时的节点
		 * */
		protected var downNode:Node;
		
		public function DefaultController(topo:Topo=null, active:Boolean=false ,cursor:Class = null)
		{
			super(topo, active, cursor);
		}
		
		override protected function register():void
		{
			if(topo)
			{
				installPlugins([
					 new SelectNodePlugin(topo)
				]);
				
				topo.addEventListener(MouseEvent.CLICK,onClick);
			}
		}
		
		override protected function unregister():void
		{
			if(topo)
			{
				topo.removeEventListener(MouseEvent.CLICK,onClick);
			}
			
			super.unregister();
		}
		
		protected function onClick(evt:MouseEvent):void
		{
			trace("DefaultController >>> onClick");
			var x:Number = evt.currentTarget.mouseX;
			var y:Number = evt.currentTarget.mouseY;
			
			topo.selectionModel.clear();
			downPoint = new Point(evt.currentTarget.mouseX,evt.currentTarget.mouseY);
			
			downNode = topo.getElementUnderPoint(downPoint.x,downPoint.y);
			if(downNode)
			{ 
				topo.dispatchEvent(new InteractionEvent(
					InteractionEvent.CLICK_ELEMENT,downNode));
			}
			else
			{
				topo.dispatchEvent(new InteractionEvent(
					InteractionEvent.CLICK_BACKGROUND));
			}
		}
	}
}