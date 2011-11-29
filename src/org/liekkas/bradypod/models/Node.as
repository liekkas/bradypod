package org.liekkas.bradypod.models
{
	import mx.core.UIComponent;
	
	import org.liekkas.bradypod.models.ui.NodeUI;

	/**
	 * 节点
	 * @author liekkas.zeng
	 * @date 2011-11-25 17:19:11
	 * */
	public class Node extends Element
	{
		protected var _x:Number;

		public function get x():Number
		{
			return _x;
		}

		public function set x(value:Number):void
		{
			_x = value;
		}

		
		protected var _y:Number;

		public function get y():Number
		{
			return _y;
		}

		public function set y(value:Number):void
		{
			_y = value;
		}

		
		protected var _w:Number;

		public function get w():Number
		{
			return _w;
		}

		public function set w(value:Number):void
		{
			_w = value;
		}

		
		protected var _h:Number;

		public function get h():Number
		{
			return _h;
		}

		public function set h(value:Number):void
		{
			_h = value;
		}
		
		
		protected var _image:String;

		public function get image():String
		{
			return _image;
		}

		public function set image(value:String):void
		{
			_image = value;
		}

		public function Node(id:String=null)
		{
			super(id);
		}
		
		override public function get elementUI():UIComponent
		{
			var n:NodeUI = new NodeUI(this);
			return n;
		}
		
		protected var _fromEdges:Array;

		public function get fromEdges():Array
		{
			return _fromEdges;
		}

		public function set fromEdges(value:Array):void
		{
			_fromEdges = value;
		}

		
		protected var _toEdges:Array;

		public function get toEdges():Array
		{
			return _toEdges;
		}

		public function set toEdges(value:Array):void
		{
			_toEdges = value;
		}

	}
}