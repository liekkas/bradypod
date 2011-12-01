package org.liekkas.bradypod.controllers.plugins
{
	import org.liekkas.bradypod.events.InteractionEvent;
	import org.liekkas.bradypod.models.Node;
	import org.liekkas.bradypod.views.Topo;
	
	/**
	 * 添加节点插件
	 * @author liekkas.zeng
	 * */
	public class AddNodePlugin extends AbstractPlugin
	{
		public function AddNodePlugin(topo:Topo)
		{
			super(topo);
		}
		
		override public function install():void
		{
			if(topo)
			{
				topo.addEventListener(InteractionEvent.CLICK_ADD_NODE,onClickAddNode);
				trace("安装插件成功  >>> AddNodePlugin");
			}
			else
			{
				trace("安装插件失败  >>> topo为空");
			}
		}
		
		override public function uninstall():void
		{
			if(topo)
			{
				topo.removeEventListener(InteractionEvent.CLICK_ADD_NODE,onClickAddNode);
			}
		}
		
		/**
		 * 鼠标单击添加一个新节点
		 * */
		protected function onClickAddNode(evt:InteractionEvent):void
		{
			var e:Node = new Node("111");
			e.w = 50;
			e.h = 50;
			e.x = evt.currentTarget.mouseX - e.w * .5;
			e.y = evt.currentTarget.mouseY - e.h * .5;
			e.icon = "icon";
			e.name = "sss";
			topo.elementBox.add(e);
		}
	}
}