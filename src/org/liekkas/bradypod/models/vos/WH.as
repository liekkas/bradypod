package org.liekkas.bradypod.models.vos
{
	/**
	 * 大小VO
	 * @author liekkas.zeng
	 * @date 2011-11-25 15:42:44
	 * */
	public class WH
	{
		/**
		 * 宽度
		 * */
		public var w:Number;
		
		/**
		 * 高度
		 * */
		public var h:Number;
		
		public function WH(w:Number = 10,h:Number = 10)
		{
			this.w = w;
			this.h = h;
		}
	}
}