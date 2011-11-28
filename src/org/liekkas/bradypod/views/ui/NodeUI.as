package org.liekkas.bradypod.views.ui
{
	import mx.controls.Image;
	import mx.controls.Label;
	
	import org.liekkas.bradypod.models.Node;
	import org.liekkas.bradypod.models.interfaces.IElement;
	
	public class NodeUI extends ElementUI
	{
		[Embed(source="Good.png")]
		public static const GOOD:Class;
		
		protected var _node:Node;
		
		protected var img:Image;
		
		protected var label:Label;

		public function get node():Node
		{
			return _node;
		}

		public function NodeUI(node:Node)
		{
			super(node);
			img = new Image();
			img.source = GOOD;
			img.width = node.w;
			img.height = node.h;
			img.x = node.x;
			img.y = node.y;
			this.addChild(img);
			label = new Label();
			label.text = node.name;
			label.x = img.x + img.width;
			label.y = img.y + img.height;
			this.addChild(label);
		}
	}
}