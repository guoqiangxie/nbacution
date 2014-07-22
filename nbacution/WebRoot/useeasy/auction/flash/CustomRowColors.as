package {
    import fl.controls.listClasses.CellRenderer;
    import fl.controls.listClasses.ICellRenderer;
    import flash.text.TextFormat;
    
    public class CustomRowColors extends CellRenderer implements ICellRenderer {

        public function CustomRowColors():void {
            super();
        }

        override protected  function drawBackground():void {
           	var format_default:TextFormat = new TextFormat("楷体",12,0x666666);
			//format_default.align = "center";
			
			var format:TextFormat = new TextFormat("楷体",12,0xff0000);
			//format.align = "center";
			
			switch (data.flag) {
                case "0" :
                   	setStyle("textFormat",format_default); 
					setStyle("upSkin", CellRenderer_upSkin_self);
					setStyle("overSkin", CellRenderer_overSkin_self);
					setStyle("selectedUpSkin", CellRenderer_selectedUpSkin_self);
					setStyle("selectedOverSkin", CellRenderer_selectedOverSkin_self);
					break;
               	default :
					setStyle("textFormat",format); 
					setStyle("upSkin", CellRenderer_upSkin_self);
					setStyle("overSkin", CellRenderer_overSkin_self);
					setStyle("selectedUpSkin", CellRenderer_selectedUpSkin_self);
					setStyle("selectedOverSkin", CellRenderer_selectedOverSkin_self);
					break;
            }
           	super.drawBackground();
        }
    }
}
/*package {
    // Import the required component classes.
    import fl.controls.listClasses.CellRenderer;
    import fl.controls.listClasses.ICellRenderer;

    public class AlternatingRowColors extends CellRenderer implements ICellRenderer {

        
        public function AlternatingRowColors():void {
            super();
        }

        
        public static function getStyleDefinition():Object {
            return CellRenderer.getStyleDefinition();
        }

        
        override protected function drawBackground():void {
            if (_listData.index % 2 == 0) {
                setStyle("upSkin", CellRenderer_selectedOverSkin);
            } else {
                setStyle("upSkin", CellRenderer_selectedDisabledSkin);
            }
            super.drawBackground();
        }
    }
}*/
