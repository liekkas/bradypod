package org.liekkas.bradypod.utils.ds
{
	/**
	 * 集合 -- 能包含任意类型的对象
	 * @author liekkas.zeng
	 * @date 2011-11-25 15:19:19
	 * */
	public interface ICollection
	{
		/**
		 * 获得数量
		 * */
		function get size():int;
		
		/**
		 * 添加一个对象
		 * */
		function add(item:*):void;
		
		/**
		 * 在每个位置上添加对象
		 * */
		function addAt(item:*,index:int):void;
		
		/**
		 * 添加一个集合下的数据
		 * */
		function addAll(collection:ICollection):void;
		
		/**
		 * 清空
		 * */
		function clear():void;
		
		/**
		 * 是否包含某个对象
		 * */
		function contains(item:*):Boolean;
		
		/**
		 * 根据索引获得对象
		 * */
		function getItem(index:int):*;
		
		/**
		 * 根据对象获得其索引
		 * */
		function getIndex(item:*):int;
		
		/**
		 * 删除某个对象 --返回其索引位置
		 * */
		function remove(item:*):int;
		
		/**
		 * 删除某个索引上的对象 --返回这个对象
		 * */
		function removeAt(index:int):*;
		
		/**
		 * 遍历 -- 顺序遍历/逆序遍历
		 * */
		function forEach(callbackFunc:Function,reverse:Boolean = false):void;
		
		/**
		 * 排序
		 * */
		function sort(sortFunc:Function):ICollection;
	}
}