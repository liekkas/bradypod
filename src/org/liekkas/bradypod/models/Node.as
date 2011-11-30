package org.liekkas.bradypod.models
{
	import flash.geom.Rectangle;
	
	import mx.core.UIComponent;
	
	import org.liekkas.bradypod.models.ui.NodeUI;
	import org.liekkas.bradypod.models.vos.XY;

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
		
		protected var nodeUI:NodeUI;
		
		override public function get elementUI():UIComponent
		{
			nodeUI = new NodeUI(this);
			return nodeUI;
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
		
		/**
		 * 判断一个坐标是否在节点内
		 * */
		public function containXY(x:Number,y:Number):Boolean
		{
			if(this.x < x && this.x + this.w > x
				&& this.y < y && this.y + this.h > y)
				return true;
			else
				return false;
		}
		
		/**
		 * 判断节点是否在某个矩阵中
		 * */
		public function containedByRect(rect:Rectangle):Boolean
		{
			if(this.x > rect.x && this.y > rect.y
				&& this.x + this.w < rect.x + rect.width
				&& this.y + this.h < rect.y + rect.height)
				return true;
			else
				return false;
		}

		public function set selected(value:Boolean):void
		{
			nodeUI.selected(value);
		}
	}
}