package org.liekkas.bradypod.models.interfaces
{
	import flash.events.IEventDispatcher;
	
	import org.liekkas.bradypod.utils.ds.ICollection;
	
	/**
	 * 数据模型接口
	 * @author liekkas.zeng
	 * @date 2011-11-25 15:56:11
	 * */
	public interface IDataModel extends IAttribute, IEventDispatcher
	{
		/**
		 * 获得所有的子数据
		 * */
		function get children():ICollection;
		
		/**
		 * 子数据多少
		 * */
		function get childrenSize():int;
		
		/**
		 * 是否有子数据
		 * */
		function get hasChildren():Boolean;
		
		/**
		 * 图标
		 * */
		function set icon(value:String):void;
		
		function get icon():String;
		
		/**
		 * id
		 * */
		function get id():Object;
		
		function set name(value:String):void;
		
		function get name():String;
		
		function set parent(value:IDataModel):void;
		
		function get parent():IDataModel;
		
		function set toolTip(value:String):void;
		
		function get toolTip():String;
			
			
	}
}