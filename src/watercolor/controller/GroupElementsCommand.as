package watercolor.controller
{
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	
	import org.robotlegs.mvcs.Command;
	
	import watercolor.commands.vo.CommandVO;
	import watercolor.commands.vo.CreateVO;
	import watercolor.commands.vo.GroupCommandVO;
	import watercolor.elements.Layer;
	import watercolor.events.GroupingEvent;
	import watercolor.events.LayerEvent;
	import watercolor.models.WaterColorModel;
	import watercolor.models.vo.LayerPropertiesVO;
	import watercolor.utils.ExecuteUtil;
	import watercolor.utils.GroupingUtil;
	
	public class GroupElementsCommand extends Command
	{


		[Inject]
		public var event:GroupingEvent;


		[Inject]
		public var model:WaterColorModel;


		/**
		 * execute: Groups elements together inside of a group element
		 */
		override public function execute():void
		{
			if( event.elements.length > 1 )
			{
				if(multipleLayers())
				{
					Alert.show("To group the selected images, all images will be moved onto layer " + "'" +Layer(event.parent).name + "'" + ".", "", Alert.OK | Alert.CANCEL, null, confirmationHandler, null, Alert.YES);
				}
				else
				{
					executeGroupCommand();
				}
			}
		}
		
		private function confirmationHandler(event:CloseEvent):void
		{
			if (event.detail == Alert.OK)
			{
				executeGroupCommand();
				//To match recently groupped elements color with current layer color
				matchLayerColor();
			}
		}
		
		private function executeGroupCommand():void
		{
			var isolationMode:Boolean = false;
			if (model.workArea.isolationLayer && model.workArea.isolationMode)
			{
				isolationMode = true;
				model.workArea.isolationLayer.exit(false, false);
			}
			
			var vo:CommandVO = GroupingUtil.group( event.parent, event.elements );
			
			model.history.addCommand( vo );
			ExecuteUtil.execute( vo );
			
			if (isolationMode)
			{
				model.workArea.isolationLayer.enter();
			}
			
			model.selectionManager.clear();
			
			if (vo is GroupCommandVO && GroupCommandVO(vo).commands[0] is CreateVO && GroupCommandVO(vo).commands[0].element.parent)
			{
				model.selectionManager.addElement(GroupCommandVO(vo).commands[0].element);
			}
		}
		
		private function multipleLayers():Boolean
		{
			var isMultipleLayers:Boolean =  false;
			for (var x:int = 0; x < event.elements.length; x++)
			{
				if(event.elements[x].parent != event.parent)
				{
					isMultipleLayers = true;
					break;
				}
			}
			
			return isMultipleLayers;
		}
		
		private function matchLayerColor():void
		{
			var properties:LayerPropertiesVO = LayerPropertiesVO.createFromLayer(Layer(event.parent));						
			var colorVal:uint = Layer(event.parent).color;
			//Acting like color has been changed so that the layer elements will be recolored
			//Actual layer color is in RGB, Added Alpha to set it as ARGB
			Layer(event.parent).color = (255<<24) + Layer(event.parent).color;
			properties.color = colorVal;
			
			dispatch(new LayerEvent(LayerEvent.PROPERTY_CHANGE, Layer(event.parent), null, properties));
		}
		
	}
}