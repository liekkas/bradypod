package org.liekkas.bradypod.controllers.plugins
{
	/**
	 * 插件机制接口
	 * @author liekkas.zeng
	 * @date 2011-11-29 15:16:10
	 * */
	public interface IPlugin
	{
		function install();
		function uninstall();
	}
}