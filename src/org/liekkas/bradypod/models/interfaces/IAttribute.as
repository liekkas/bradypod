package org.liekkas.bradypod.models.interfaces
{
	import org.liekkas.bradypod.utils.ds.ICollection;

	/**
	 * 属性机制 -- 任何类型的数据通过实现这个接口能扩展任意属性
	 * 有点像数据对象都动态化了
	 * @author liekkas.zeng
	 * @date 2011-11-25 15:00:07
	 * */
	public interface IAttribute
	{
		/**
		 * 获取所有扩展属性
		 * */
		function get attributes():ICollection; 
		
		/**
		 * 获得属性
		 * */
		function getAttribute(key:String):*;
		
		/**
		 * 设置属性
		 * */
		function setAttribute(key:String,value:*);
	}
}