package org.liekkas.bradypod.models
{
	import mx.core.UIComponent;
	
	import org.liekkas.bradypod.models.ui.EdgeUI;

	public class Edge extends Element
	{
		protected var _fromNode:Node;

		public function get fromNode():Node
		{
			return _fromNode;
		}

		public function set fromNode(value:Node):void
		{
			_fromNode = value;
		}

		
		protected var _toNode:Node;

		public function get toNode():Node
		{
			return _toNode;
		}

		public function set toNode(value:Node):void
		{
			_toNode = value;
		}
		
		
		public function Edge(id:String=null)
		{
			super(id);
		}
		
		override public function get elementUI():UIComponent
		{
			var e:EdgeUI = new EdgeUI(this);
			return e;
		}
	}
}