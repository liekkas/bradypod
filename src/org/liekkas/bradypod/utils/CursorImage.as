package org.liekkas.bradypod.utils
{
	/**
	 * 光标手势图标
	 * @author liekkas.zeng
	 * @date 2011-11-29 13:19:52
	 * */
	public class CursorImage
	{
		//编辑模式
		[Embed(source="assets/imgs/cursor/leaf.png")]
		public static const CURSOR_DRAW:Class;
		
		//选择模式
		[Embed(source="assets/imgs/cursor/select.png")]
		public static const CURSOR_SELECT:Class;
		
		//拖拽模式
		[Embed(source="assets/imgs/cursor/hand.png")]
		public static const CURSOR_DRAG:Class;
	}
}