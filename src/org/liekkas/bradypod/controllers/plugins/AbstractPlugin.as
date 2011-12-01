package org.liekkas.bradypod.controllers.plugins
{
	import org.liekkas.bradypod.views.Topo;
	
	/**
	 * 抽象基本插件
	 * @author liekkas.zeng
	 * */
	public class AbstractPlugin implements IPlugin
	{
		/**
		 * topo实例
		 * */
		protected var _topo:Topo;
		
		
		public function AbstractPlugin(topo:Topo)
		{
			this.topo = topo;
		}
		
		public function get topo():Topo
		{
			return _topo;
		}
		
		public function set topo(value:Topo):void
		{
			if(topo !== value)
			{
				_topo = value;
			}
		}
		
		public function install():void
		{
		}
		
		public function uninstall():void
		{
		}
	}
}