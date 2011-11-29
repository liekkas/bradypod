package org.liekkas.bradypod.controllers
{
	import org.liekkas.bradypod.views.Topo;

	/**
	 * 控制类接口
	 * @author liekkas.zeng
	 * @date 2011-11-28 17:50:51
	 * */
	public interface IController
	{
		/**
		 * 控制topo --!
		 * */
		function get topo():Topo;
		function set topo(value:Topo):void;
		
		/**
		 * 是否激活这个控制器
		 * */
		function get active():Boolean;
		function set active(value:Boolean):void;
		
		/**
		 * 销毁
		 * */
		function destory():Boolean;
	}
}