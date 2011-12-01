package org.liekkas.bradypod.controllers.plugins
{
	import org.liekkas.bradypod.events.InteractionEvent;
	import org.liekkas.bradypod.models.Node;
	import org.liekkas.bradypod.models.vos.XY;
	import org.liekkas.bradypod.utils.DrawUtils;
	import org.liekkas.bradypod.views.Topo;
	import org.liekkas.bradypod.models.interfaces.IElement;
	import org.liekkas.bradypod.models.Edge;
	
	/**
	 * 绘制边插件
	 * @author liekkas.zeng
	 * */
	public class DrawEdgePlugin extends AbstractPlugin
	{
		protected var _elements:Array;
		
		/**
		 * 拓扑元素
		 * */
		public function get elements():Array
		{
			return _elements ? _elements : topo.elementBox.elements.source;
		}
		
		/**
		 * 绘制边时的起始node
		 * */
		protected var fromNode:Node;
		
		/**
		 * 绘制边时的终止node
		 * */
		protected var toNode:Node;
		
		/**
		 * 绘制边时沿途碰撞过的node数组
		 * */
		protected var collides:Array = [];
		
		public function DrawEdgePlugin(topo:Topo)
		{
			super(topo);
		}
		
		override public function install():void
		{
			if(topo)
			{
				topo.addEventListener(InteractionEvent.DRAW_EDGE_START,onDrawEdgeStart);
				topo.addEventListener(InteractionEvent.DRAW_EDGE_END,onDrawEdgeEnd);
				trace("安装插件成功  >>> DrawEdgePlugin");
			}
			else
			{
				trace("安装插件失败  >>> topo为空!!!");
			}
		}
		
		override public function uninstall():void
		{
			if(topo)
			{
				topo.removeEventListener(InteractionEvent.DRAW_EDGE_START,onDrawEdgeStart);
				topo.removeEventListener(InteractionEvent.DRAW_EDGE_END,onDrawEdgeEnd);
			}
		}
		
		protected function onDrawEdgeStart(evt:InteractionEvent):void
		{
			fromNode = evt.payload;
			var x:Number = evt.mouseEvent.currentTarget.mouseX;
			var y:Number = evt.mouseEvent.currentTarget.mouseY;
			
			toNode = topo.getElementUnderPoint(x,y);
			if(toNode && fromNode!= toNode)
			{
				toNode.selected = true;
				collides.push(toNode);
			}
			else
			{
				purgeCollides();
			}
			
			var startXY:XY = new XY(fromNode.x + fromNode.w*.5,fromNode.y + fromNode.h * .5);
			var endXY:XY = new XY(x,y);
			
			DrawUtils.drawArrowLine(topo.graphLayer.graphics,startXY,endXY);
		}
		
		/**
		 * 绘制结束
		 * */
		protected function onDrawEdgeEnd(evt:InteractionEvent):void
		{
			/**
			 * 如果终止节点存在，则加一个边元素
			 * */
			if(toNode)
			{
				var e:Edge = new Edge();
				e.fromNode = fromNode;
				e.toNode = toNode;
				topo.elementBox.add(e);
				purgeCollides();
				toNode = null;
			}
			fromNode.selected = false;
			fromNode = null;
			topo.graphLayer.graphics.clear();
		}
		
		/**
		 * 清理collides
		 * */
		protected function purgeCollides():void
		{
			for each(var ele:IElement in collides)
			{
				Node(ele).selected = false;
			}
			
			collides = [];
		}
	}
}