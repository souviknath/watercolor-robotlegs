package watercolor.events
{
	import flash.events.Event;
	
	import watercolor.elements.Text;
	
	/**
	 * 
	 * @author Jeremiah
	 */
	public class StyleTextAreaEvent extends Event
	{
		/**
		 * Event for
		 * @default 
		 */
		public static const EVENT_BOLD_TEXT:String = "eventBoldTextArea";
		
		public static const EVENT_UN_BOLD_TEXT:String = "eventUnBoldTextArea";
		
		public static const EVENT_ITALIC_TEXT:String = "eventItalicTextArea";
		
		public static const EVENT_UN_ITALIC_TEXT:String = "eventUnItalicTextArea";
		
		public static const EVENT_SIZE_TEXT:String = "eventSizeTextArea";
		
		public static const EVENT_COLOR_TEXT:String = "eventColorTextArea";
		
		public static const EVENT_ALIGN_LEFT_TEXT:String = "eventAlignLeftText";
		
		public static const EVENT_ALIGN_MIDDLE_TEXT:String = "eventAlignMiddleText";
		
		public static const EVENT_ALIGN_RIGHT_TEXT:String = "eventAlignRightText";
		
		public static const EVENT_LIST_TEXT:String = "eventListText";
		
		public static const EVENT_TEXT_AREA_CLICK:String = "eventTextAreaClick";
		
		public static const EVENT_TEXT_AREA_ADD_LINK:String = "eventTextAreaAddLink";
		
		public static const EVENT_TEXT_AREA_REMOVE_LINK:String = "eventTextAreaRemoveLink";
		
		public var textArea:Text;
		
		public var args:Array;
		
		/**
		 * 
		 * @param type
		 * @param bubbles
		 * @param cancelable
		 */
		public function StyleTextAreaEvent(type:String, textArea:Text, ...args)
		{
			this.textArea = textArea;
			this.args = args;
			
			super(type, bubbles, cancelable);
		}
		
		/**
		 * Overriden <code>clone()</code> method used to clone event; commonly used in bubbling.
		 */
		override public function clone():Event
		{
			return new StyleTextAreaEvent(this.type, this.textArea, this.args);
		}
	}
}