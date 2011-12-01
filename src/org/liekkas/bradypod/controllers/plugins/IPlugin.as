package org.liekkas.bradypod.controllers.plugins
{
	import org.liekkas.bradypod.views.Topo;

	/**
	 * 插件机制接口
	 * @author liekkas.zeng
	 * @date 2011-11-29 15:16:10
	 * */
	public interface IPlugin
	{
		function get topo():Topo;
		function set topo(value:Topo):void;
		
		function install():void;
		function uninstall():void;
	}
}