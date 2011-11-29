package org.liekkas.bradypod.models.ui
{
	import org.liekkas.bradypod.models.Edge;
	import org.liekkas.bradypod.models.Node;
	import org.liekkas.bradypod.models.interfaces.IElement;
	
	public class EdgeUI extends ElementUI
	{
		public function EdgeUI(edge:Edge)
		{
			super(edge);
			
			var f:Node = edge.fromNode;
			var t:Node = edge.toNode;
			
			this.graphics.lineStyle(1,0);
			this.graphics.beginFill(0);
			this.graphics.moveTo(f.x+f.w*.5,f.y+f.h*.5);
			this.graphics.lineTo(t.x+t.w*.5,t.y+t.h*.5);
			this.graphics.endFill();
		}
	}
}