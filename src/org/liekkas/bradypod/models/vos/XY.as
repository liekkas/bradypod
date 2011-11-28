package org.liekkas.bradypod.models.vos
{
	/**
	 * 位置VO
	 * @author liekkas.zeng
	 * @date 2011-11-25 15:41:45
	 * */
	public class XY
	{
		/**
		 * x坐标
		 * */
		public var x:Number;
		
		/**
		 * y坐标
		 * */
		public var y:Number;
		
		public function XY(x:Number = 0,y:Number = 0)
		{
			this.x = x;
			this.y = y;
		}
	}
}