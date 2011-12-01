package org.liekkas.bradypod.controllers
{
	import org.liekkas.bradypod.models.Node;
	import org.liekkas.bradypod.models.interfaces.IElement;
	import org.liekkas.bradypod.views.Topo;
	
	/**
	 * 布局控制器 -- 通过安装具体插件实现各种布局
	 * @author liekkas.zeng
	 * @date 2011-11-30 16:16:53
	 * */
	public class LayoutController extends BaseController
	{
		protected static const GAP:int = 10; 
		
		public function LayoutController(topo:Topo=null, active:Boolean=false, cursor:Class=null)
		{
			super(topo, active, cursor);
		}
		
		public function regionLayout():void
		{
			var width:Number = topo.width;
			var height:Number = topo.height;
			var nodesNum:int = topo.elementBox.nodesNum;
			var nodesLen:Number = topo.elementBox.nodesLen;
			var nodes:Array = topo.elementBox.nodes;
			
			//最多放这么多
			var maxNum:int = Math.floor(width*nodesNum/(nodesLen+nodesNum*GAP));
			
			var scale:Number = maxNum > nodesNum ? 1 : maxNum/nodesNum;
			var padding:Number = (width - nodesLen*scale - (nodesNum-1)*GAP*scale)*.5;
			var preOffset:Number; //前者的x偏移量
			for(var i:int = 0;i < nodesNum;i++)
			{
				var node:Node = nodes[i];
				if(node)
				{
					node.w *= scale;
					node.h *= scale;
					if(i == 0)
					{
						node.setXY(padding,(height - node.h*scale)*.5);
					}
					else
					{
						node.setXY(preOffset + GAP*scale,(height - node.h*scale)*.5);
					}
					
					preOffset = node.x + node.w;	
				}
			}
		}
	}
}