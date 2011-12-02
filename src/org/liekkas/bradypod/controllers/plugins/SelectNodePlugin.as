package org.liekkas.bradypod.controllers.plugins
{
	import flash.events.MouseEvent;
	
	import org.liekkas.bradypod.events.InteractionEvent;
	import org.liekkas.bradypod.models.Node;
	import org.liekkas.bradypod.views.Topo;
	
	/**
	 * 点击选中节点插件
	 * @author liekkas.zeng
	 * */
	public class SelectNodePlugin extends AbstractPlugin
	{
		public function SelectNodePlugin(topo:Topo)
		{
			super(topo);
		}
		
		override public function install():void
		{
			if(topo)
			{
				topo.addEventListener(InteractionEvent.CLICK_ELEMENT,onClickElement);
				trace("安装插件成功  >>> SelectNodePlugin");
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
				topo.removeEventListener(InteractionEvent.CLICK_ELEMENT,onClickElement);
				trace("卸载插件成功  >>> SelectNodePlugin");
			}
			else
			{
				trace("卸载插件失败  >>> topo为空!!!");
			}
		}
		
		protected function onClickElement(evt:InteractionEvent):void
		{
			var selectedEle:Node = evt.payload;
			topo.selectionModel.add(selectedEle);
		}
	}
}