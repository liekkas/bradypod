package org.liekkas.bradypod.models.interfaces
{
	import mx.core.UIComponent;

	/**
	 * 拓扑元素接口
	 * @author liekkas.zeng
	 * @date 2011-11-25 17:05:01
	 * */
	public interface IElement extends IAttribute
	{
		function get id():String;
		
		function set name(value:String):void;
		function get name():String; 
		
		function set icon(value:String):void;
		function get icon():String;
		
		function get elementUI():UIComponent;
	}
}