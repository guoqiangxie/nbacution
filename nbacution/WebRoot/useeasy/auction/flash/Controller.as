package {
	
    import flash.display.*;
	import flash.net.*;
	import flash.events.*;
	import fl.controls.*;
	import fl.data.DataProvider;
	import flash.text.*;
	import flash.utils.Timer;
	
	import fl.controls.listClasses.*;
	import fl.controls.dataGridClasses.DataGridColumn;
	
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	
	public class Controller extends MovieClip {
		
        private var socket:Socket;
		
		private var param:Object = root.loaderInfo.parameters;
		
		private var auction_port:String;
		private var auction_id:String;
		private var account_id:String;
		private var auction_num:String; 
		private var xml_num:String;
		private var auction_name:String;
		
		private var xmlLoader:BulkLoader;
		private var xml_file:XML;
		private var imgLoader:BulkLoader;
		
		private var startLoadXml_timer:Timer;
		private var startLoadItem_timer:Timer;
		
		private var line:String = "";
		private var line_array:Array;
		private var line_length:uint;
		
		private var connect_status:String;
		
		private var xmlProgressBar:ProgressBar;
		private var barLabel:Label;
		
		private var heart_timer:Timer;
		private var heart_counter:uint = 2;
		
		private var item_id:String;
		private var item_index:String;
		private var item_order:String;
		private var item_valuation_method:String;
		private var item_count_number:String;
		private var item_commission_type:String;
		private var item_commission_value:String;
		private var item_margin:String;
		private var item_price:String;
		private var team_id:String;
						
		private var item_status:String;
		private var item_price_range:String;
		private var item_price_range_type:String;
		private var item_price_range_mode:String;
		private var pause_flag:String;
		private var price_user_id:String;
		private var price_user_type:String;
		private var price_user_bid:String;
		
		private var price_array:Array;
		private var level_fir:String;
		private var level_sec:String;
		private var level_thi:String;
		private var level_fou:String;
		private var level_fif:String;
		
		private var com_amo_array:Array;
		private var commission_val:String;
		private var amount_val:String;
		
		private var item_count:String;
		private var item_status_list:Array;
		private var item_status_fir:String;
		private var item_status_sec:String;
		private var item_status_thi:String;
		private var count_time_flag:String;
		private var auction_status:String;
						
		private var item_name:String;
		private var item_count_unit:String;
		private var item_count_content:String;
		private var item_description:String;
		private var item_pic_url:String;
		
		//private var base_url:String = "http://wangpai1.staa.com.cn/";
		private var base_url:String = "http://172.16.171.80:8180/";
		//private var base_url:String = "http://localhost:8180/auction_n/";
		private var pic_status_fir = base_url + "flash/image/mbtn_01.png";
		private var pic_status_sec = base_url + "flash/image/mbtn_02.png";
		private var pic_status_thi = base_url + "flash/image/mbtn_03.png";
		private var pic_status_fou = base_url + "flash/image/mbtn_04.png";
		private var pic_status_fif = base_url + "flash/image/mbtn_05.png";
		private var pic_status_six = base_url + "flash/image/mbtn_06.png";
		private var no_pic = base_url + "flash/image/nopic.jpg";
		
		private var user_number:String;
		
		private var item_id_flag:String;
		
		private var item_page_index_flag:String;
		
		private var count_down_timer:Timer;
		private var count_down_time:int;
		
		private var status_counter:int = 0;
		private var status_counter_max:int = 20;
		
		var dataGridFormat:TextFormat = new TextFormat("宋体",14,0x666666);
		var dataGridSpecialFormat:TextFormat = new TextFormat("宋体",14,0xff0000);
		var priceDataProvider:DataProvider = new DataProvider();
		var dealDataProvider:DataProvider = new DataProvider();
		
		var dealAlertBox:DealAlertBox;
		var auctionCloseAlertBox:AuctionCloseAlertBox;
		var connectCloseAlertBox:ConnectCloseAlertBox;
		
		private var videoPlayer:VideoPlayer;
		private var serverURL:String;
		private var videoURL:String;
		
		public function Controller() {
			if(param["auction_port"] != null){
				auction_port = param["auction_port"];
			}else{
				auction_port = "6956";
			}
			setDefaultStatus();
			socket = new Socket();
			socket.connect("172.16.171.80",6956);
			//socket.connect("61.129.51.26",new uint(auction_port));
			//socket.connect("114.80.68.98",6956);
			socket.addEventListener(Event.CONNECT,connectHandler);
		   	socket.addEventListener(Event.CLOSE,closeHandler);
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			socket.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			socket.addEventListener(ProgressEvent.SOCKET_DATA,socketDataHandler);
			//socket.timeout = 5;
		}
		
		private function setDefaultStatus():void{
			/*if(heart_timer != null){
				heart_timer.removeEventListener(TimerEvent.TIMER,heartStart);
				heart_timer.stop();
			}*/
			
			auctionStatus.text = "-";
			aliveNum.text = "当前在线:-人";
			
			videoButton.removeEventListener(MouseEvent.CLICK, stratVideoHandler);
			
			count_down_text.visible = false;
			itemTitle.text = "拍品信息";
			item_image.source = "";
			itemName.text = "拍品名称:-"; 
			itemPrice.text = "起拍价格: -";
			itemCommissionType.text = "佣金标准:-";
			itemUnit.text = "数量/单位:-";
			itemValuationMethod.text = "计价方式:-";
			itemMargin.text = "需保证金:-";
			
			itemDescriptionTitle.text = "拍品描述";
			itemDescription.editable = false;
			itemDescription.htmlText = "<span><font size='14' color='#333333' face='宋体'></font></span>";
			
			auctionName.text = "-";
			itemValuationType.text = "-";
			itemCount.text = "/-";
			itemCurrentPrice.htmlText = "";
			itemCommissionValue.text = "佣金标准:-";
			itemCommissionPrice.text = "佣金金额:-";
			itemTotalPrice.text = "含佣金总价:-";
			itemStatus.htmlText = "<b>-</b>";
			
			priceStatusAlive.gotoAndStop(2);
			priceStatusAlive.typeTitle.htmlText = "现场出价";
			priceStatusWeb.gotoAndStop(2);
			priceStatusWeb.typeTitle.htmlText = "网络出价";
			
			bjms_text.text = "报价模式";
			sdbj_text.text = "手动报价";
			sdbjxsd_text.htmlText = "<b>.</b>";
			sdcjxsd_text.htmlText = "<b>.</b>";
			
			gdbj_text.htmlText = "固定报价";
			ewlbj_text.htmlText = "250报价";
			ewbbj_text.htmlText = "258报价";
			jfbj_text.htmlText = "角分报价";
			
			returnPriceButton.gotoAndStop(2);
			returnPriceButton.label_text.text = "恢复上一价格";
			countTimeButton.gotoAndStop(2);
			countTimeButton.label_text.htmlText = "落槌倒计时";
			countTimeCancelButton.gotoAndStop(2);
			startButton.gotoAndStop(2);
			startButton.label_text.htmlText = "开始";
			dealButton.gotoAndStop(2);
			dealButton.label_text.htmlText = "成交";
			bidFailureButton.gotoAndStop(2);
			bidFailureButton.label_text.htmlText = "流标";
			nextItemButton.gotoAndStop(2);
			nextItemButton.label_text.htmlText = "准备下一拍品";
			redoItemButton.gotoAndStop(2);
			redoItemButton.label_text.htmlText = "重拍";
			pauseItemButton.gotoAndStop(2);
			pauseItemButton.label_text.htmlText = "暂停";
			continueItemButton.gotoAndStop(2);
			continueItemButton.label_text.htmlText = "继续";
			
			currentPriceButton.gotoAndStop(2);
			currentPriceButton.label_text.htmlText = "<b>0</b>";
			currentPriceFirButton.gotoAndStop(2);
			currentPriceFirButton.label_text.htmlText = "<b>0</b>";
			currentPriceSecButton.gotoAndStop(2);
			currentPriceSecButton.label_text.htmlText = "<b>0</b>";
			currentPriceThiButton.gotoAndStop(2);
			currentPriceThiButton.label_text.htmlText = "<b>0</b>";
			currentPriceFouButton.gotoAndStop(2);
			currentPriceFouButton.label_text.htmlText = "<b>0</b>";
			bidDelayButton.gotoAndStop(2);
			bidDelayButton.label_text.htmlText = "缓拍";
			bidCancelButton.gotoAndStop(2);
			bidCancelButton.label_text.htmlText = "撤拍";
			dealCancelButton.gotoAndStop(2);
			dealCancelButton.label_text.htmlText = "成撤";
			auctionStartButton.gotoAndStop(2);
			auctionStartButton.label_text.htmlText = "拍卖会开始";
			
			gdbj_radio.label = "";
			gdbj_radio.enabled = false;  
			gdbj_radio.groupName = "fdms";
			ewlbj_radio.label = "";
			ewlbj_radio.enabled = false;  
			ewlbj_radio.groupName = "fdms";
			ewbbj_radio.label = "";
			ewbbj_radio.enabled = false;  
			ewbbj_radio.groupName = "fdms";
			jfbj_radio.label = "";
			jfbj_radio.enabled = false;  
			jfbj_radio.groupName = "fdms";
			
			gdbjFirButton.gotoAndStop(2);
			gdbjFirButton.label_text.htmlText = "<b>100</b>";
			gdbjSecButton.gotoAndStop(2);
			gdbjSecButton.label_text.htmlText = "<b>200</b>";
			gdbjThiButton.gotoAndStop(2);
			gdbjThiButton.label_text.htmlText = "<b>500</b>";
			gdbjFouButton.gotoAndStop(2);
			gdbjFouButton.label_text.htmlText = "<b>1000</b>";
			gdbjFifButton.gotoAndStop(2);
			gdbjFifButton.label_text.htmlText = "<b>2000</b>";
			gdbjSixButton.gotoAndStop(2);
			gdbjSixButton.label_text.htmlText = "<b>5000</b>";
			gdbjSevButton.gotoAndStop(2);
			gdbjSecButton.label_text.htmlText = "<b>10000</b>";
			
			sdbjzs_input.editable = false;
			sdbjzs_input.maxChars = 12;
			sdbjxs_input.editable = false;
			sdbjxs_input.maxChars = 12;
			bjszButton.gotoAndStop(2);
			bjszButton.label_text.htmlText = "设置";
			
			sdbjFirButton.gotoAndStop(1);
			sdbjFirButton.label_text.htmlText = "十";
			sdbjSecButton.gotoAndStop(1);
			sdbjSecButton.label_text.htmlText = "百";
			sdbjThiButton.gotoAndStop(1);
			sdbjThiButton.label_text.htmlText = "千";
			sdbjFouButton.gotoAndStop(1);
			sdbjFouButton.label_text.htmlText = "万";
			sdbjFifButton.gotoAndStop(1);
			sdbjFifButton.label_text.htmlText = "十万";
			sdbjSixButton.gotoAndStop(1);
			sdbjSixButton.label_text.htmlText = "百万";
			
			sdcjzs_input.editable = false;
			sdcjzs_input.maxChars = 12;
			sdcjxs_input.editable = false;
			sdcjxs_input.maxChars = 12;
			
			sdcjButton.gotoAndStop(2);
			sdcjButton.label_text.htmlText = "手动出价";
			sqpjButton.gotoAndStop(2);
			sqpjButton.label_text.htmlText = "设起拍价";
			//removeChild(sqpjButton);
			
			aliveStatusTitle.text = "现在状态";
			aliveStatus.htmlText = "<span><font size='14' color='#333333' face='宋体'></font></span>";
			aliveStatus.editable = false;
			djssd_input.editable = false;
			djssd_input.maxChars = 12;
			djssdButton.gotoAndStop(2);
			djssdButton.label_text.htmlText = "倒计时设定";
			
			recordPriceButton.gotoAndStop(1);
			recordPriceButton.label_text.text = "出价记录";	
			recordDealButton.gotoAndStop(1);
			recordDealButton.label_text.text = "成交记录";
			
			priceDataGrid.setStyle("headerTextFormat", dataGridFormat);
			priceDataGrid.setRendererStyle("textFormat", dataGridFormat);
			priceDataGrid.resizableColumns = false;
			priceDataGrid.sortableColumns = false;
			priceDataGrid.dataProvider = priceDataProvider;
			priceDataGrid.rowCount = new uint(9);
			priceDataGrid.rowHeight = new uint(29);
			priceDataGrid.setStyle("cellRenderer", CustomRowColors);
			var col_time:DataGridColumn = new DataGridColumn("时间");
			col_time.width = new uint(50);
			//dgc.cellRenderer = "MyCustomCellRendererClass";
			var col_type:DataGridColumn = new DataGridColumn("用户");
			col_type.width = new uint(35);
			var col_price:DataGridColumn = new DataGridColumn("出价");
			col_price.width = new uint(69);
			var col_index:DataGridColumn = new DataGridColumn("拍品");
			col_index.width = new uint(35);
			var col_bid:DataGridColumn = new DataGridColumn("拍牌");
			col_bid.width = new uint(35);
			priceDataGrid.addColumn(col_time);
			priceDataGrid.addColumn(col_type);
			priceDataGrid.addColumn(col_price);
			priceDataGrid.addColumn(col_index);
			priceDataGrid.addColumn(col_bid);
			
			dealDataGrid.setStyle("headerTextFormat", dataGridFormat);
			dealDataGrid.setRendererStyle("textFormat", dataGridFormat);
			dealDataGrid.resizableColumns = false;
			dealDataGrid.sortableColumns = false;
			dealDataGrid.dataProvider = dealDataProvider;
			dealDataGrid.rowCount = new uint(9);
			dealDataGrid.rowHeight = new uint(29);
			dealDataGrid.setStyle("cellRenderer", CustomRowColors);
			dealDataGrid.addColumn(col_time);
			dealDataGrid.addColumn(col_type);
			dealDataGrid.addColumn(col_price);
			dealDataGrid.addColumn(col_index);
			dealDataGrid.addColumn(col_bid);
			
			itemListTitle.text = "拍品列表";
			itemListIndexFir_text.border = true;
			itemListIndexSec_text.border = true;
			itemListIndexThi_text.border = true;
			selectItem_input.editable = false;
			selectItem_input.maxChars = 5;
			selectItemButton.gotoAndStop(2);
			
			/*itemListImgFir.source = "";
			itemListImgSec.source = "";
			itemListImgThi.source = "";
			*/
			
			//..上下页
			
		}
		
		private function connectHandler(e:Event):void{
			trace("socket connected:  " + e);
			if(param["auction_id"] != null){
				auction_id = param["auction_id"];
			}else{
				auction_id = "1420";
			}
			if(param["user_id"] != null){
				account_id = param["user_id"];
			}else{
				account_id = "3";
			}
			if(param["auction_num"] != null){
				auction_num = param["auction_num"];
			}else{
				auction_num = "DgPTFUvU6f7wS4aQhWax";
			}
			if(param["xml_num"] != null){
				xml_num = param["xml_num"];
			}else{
				xml_num = "57pXC0G418hBGY2o3i6M";
			}
			
			if(param["serverURL"] != null){
				serverURL = param["serverURL"];
			}else{
				serverURL = "-";  
			}
			if(param["videoURL"] != null){
				videoURL = param["videoURL"];
			}else{
				videoURL = "-";  
			}
			
			xmlLoader = new BulkLoader("xml_loader");
			imgLoader = new BulkLoader("img-loader");
			
			startLoadXml_timer = new Timer(3000,10);
			startLoadXml_timer.addEventListener(TimerEvent.TIMER,startLoadXml);
			startLoadXml_timer.start();
		}
		
		function okConnectCloseHandler(evt:Event):void {	
			cleanConnectClose(evt);
		}
		function closeConnectCloseHandler(evt:Event):void {	
			cleanConnectClose(evt);
	    }
		
		function cleanConnectClose(evt:Event):void{
	      	evt.currentTarget.removeEventListener("okEvent",okConnectCloseHandler);
	      	evt.currentTarget.removeEventListener("closeEvent",closeConnectCloseHandler);	
		  	removeChild(evt.currentTarget as DisplayObject);
	    }
		private function closeHandler(e:Event):void{
			trace("socket closed:  " + e);
			if(startLoadXml_timer != null){
				startLoadXml_timer.stop();
				startLoadXml_timer.removeEventListener(TimerEvent.TIMER,startLoadXml);
			}
			if(startLoadItem_timer != null){
				startLoadItem_timer.stop();
				startLoadItem_timer.removeEventListener(TimerEvent.TIMER,startLoadItem);
			}
			if(heart_timer != null){
				heart_timer.stop();
				heart_timer.removeEventListener(TimerEvent.TIMER,heartStart);
			}
			setDefaultStatus();
			connectCloseAlertBox = new ConnectCloseAlertBox();
			connectCloseAlertBox.addEventListener("okEvent",okConnectCloseHandler);
	       	connectCloseAlertBox.addEventListener("closeEvent",closeConnectCloseHandler);
			connectCloseAlertBox.title.text = "服务器连接断开！";
			addChild(connectCloseAlertBox);
		}
		
		private function ioErrorHandler(e:IOErrorEvent):void {
			trace("ioErrorHandler: " + e);
			if(startLoadXml_timer != null){
				startLoadXml_timer.stop();
				startLoadXml_timer.removeEventListener(TimerEvent.TIMER,startLoadXml);
			}
			if(startLoadItem_timer != null){
				startLoadItem_timer.stop();
				startLoadItem_timer.removeEventListener(TimerEvent.TIMER,startLoadItem);
			}
			if(heart_timer != null){
				heart_timer.stop();
				heart_timer.removeEventListener(TimerEvent.TIMER,heartStart);
			}
			setDefaultStatus();
			connectCloseAlertBox = new ConnectCloseAlertBox();
			connectCloseAlertBox.addEventListener("okEvent",okConnectCloseHandler);
	       	connectCloseAlertBox.addEventListener("closeEvent",closeConnectCloseHandler);
			connectCloseAlertBox.title.text = "服务器连接断开！";
			addChild(connectCloseAlertBox);
		}
		
		private function securityErrorHandler(e:SecurityErrorEvent):void {
			trace("securityErrorHandler: " + e);
			if(startLoadXml_timer != null){
				startLoadXml_timer.stop();
				startLoadXml_timer.removeEventListener(TimerEvent.TIMER,startLoadXml);
			}
			if(startLoadItem_timer != null){
				startLoadItem_timer.stop();
				startLoadItem_timer.removeEventListener(TimerEvent.TIMER,startLoadItem);
			}
			if(heart_timer != null){
				heart_timer.stop();
				heart_timer.removeEventListener(TimerEvent.TIMER,heartStart);
			}
			setDefaultStatus();
			connectCloseAlertBox = new ConnectCloseAlertBox();
			connectCloseAlertBox.addEventListener("okEvent",okConnectCloseHandler);
	       	connectCloseAlertBox.addEventListener("closeEvent",closeConnectCloseHandler);
			connectCloseAlertBox.title.text = "服务器连接断开！";
			addChild(connectCloseAlertBox);
		}
		
		public function startLoadXml(e:TimerEvent):void{
			trace("startLoadXml_timer");
			sendMessage("90", (auction_id + "&" + account_id + "&cl&" + auction_num + "&"));
		}
		
		private function onXMLItemLoaded(e:Event) : void{
            //trace("xml loaded:__________!");
		}
		private function onXMLItemProgress(e:BulkProgressEvent) : void{
            //trace(e.loadingStatus());
		}
		private function onXMLBulkLoaderError(evt :ErrorEvent ) : void{
			trace("onXMLBulkLoaderError");
			xmlProgressBar.removeEventListener(ProgressEvent.PROGRESS, barProgressHandler);
			xmlProgressBar.removeEventListener(Event.COMPLETE, barCompleteHandler);
			if(startLoadXml_timer != null){
				startLoadXml_timer.stop();
				startLoadXml_timer.removeEventListener(TimerEvent.TIMER,startLoadXml);
			}
			xmlProgressBar.visible = false;
			barLabel.visible = false;
			if(contains(xmlProgressBar))
				removeChild(xmlProgressBar);
			if(contains(barLabel))
    			removeChild(barLabel);
			socket.close();
			setDefaultStatus();
			connectCloseAlertBox = new ConnectCloseAlertBox();
			connectCloseAlertBox.addEventListener("okEvent",okConnectCloseHandler);
	       	connectCloseAlertBox.addEventListener("closeEvent",closeConnectCloseHandler);
			connectCloseAlertBox.title.text = "文件加载失败！";
			addChild(connectCloseAlertBox);
		}
		
		function barProgressHandler(event:ProgressEvent):void {
			xmlProgressBar.visible = true;
			barLabel.htmlText = "<font color='#000000' size='22' font='宋体'>文件加载: " + int(event.currentTarget.percentComplete) + "%</font>";
		}
		
		function barCompleteHandler(event:Event):void {
    		trace("xml complete:");
			if(startLoadXml_timer != null){
				startLoadXml_timer.stop();
				startLoadXml_timer.removeEventListener(TimerEvent.TIMER,startLoadXml);
			}
			xmlProgressBar.removeEventListener(ProgressEvent.PROGRESS, barProgressHandler);
			xmlProgressBar.removeEventListener(Event.COMPLETE, barCompleteHandler);
			
			startLoadItem_timer = new Timer(3000);
			startLoadItem_timer.addEventListener(TimerEvent.TIMER,startLoadItem);
			startLoadItem_timer.start();
			
		}
		
		public function startLoadItem(e:TimerEvent):void{
			trace("startLoadItem_timer");
			sendMessage("00", (Math.floor(Math.random()*1000) + "&" + Math.floor(Math.random()*1000) + "&"));
		}
		
		private function sendMessage(packageFlag:String, messageInfo:String):void{
			if(socket.connected){
				var sendMessage:String = "";
				var message_len:uint = 22;
				message_len += messageInfo.length;
				if(message_len >= 100){
					sendMessage = "ues_t_a&" + message_len + "&" + packageFlag + "&" + messageInfo + "uee_n_d\n";
				}else{
					sendMessage = "ues_t_a&0" + message_len + "&" + packageFlag + "&" + messageInfo + "uee_n_d\n";
				}
				socket.writeUTFBytes(sendMessage);
				socket.flush();
			}else{
				trace("socket is closed");
			}
		}
		
		private function socketDataHandler(e:ProgressEvent):void{
			line += socket.readUTFBytes(socket.bytesAvailable);
			//line += socket.readMultiByte(socket.bytesAvailable,"utf8");
			trace(line);
			if( line.indexOf("<cross-domain-policy>") != -1 
					&& line.indexOf("</cross-domain-policy>") != -1 ){
				line = line.slice(line.indexOf("</cross-domain-policy>") + 22);
			}
			while( line.indexOf("ues_t_a") != -1 && line.indexOf("uee_n_d") != -1 
						&& (line.indexOf("ues_t_a")<line.indexOf("uee_n_d")) ){
				line_array = line.split("&");
				line_length = ( line.indexOf("uee_n_d") - line.indexOf("ues_t_a") ) + 7;
				if( line_length != new uint(line_array[1]) ){
					trace("error:line length___________________________________");
				}else{
					heart_counter = 2;
					connect_status = line_array[2];
					if(connect_status == "90"){
						imgLoader.add(pic_status_fir,{priority:20, id:"fir_status_fir", maxTries: 1});
						imgLoader.add(pic_status_sec,{priority:20, id:"fir_status_sec", maxTries: 1});
						imgLoader.add(pic_status_thi,{priority:20, id:"fir_status_thi", maxTries: 1});
						imgLoader.add(pic_status_fou,{priority:20, id:"fir_status_fou", maxTries: 1});
						imgLoader.add(pic_status_fif,{priority:20, id:"fir_status_fif", maxTries: 1});
						imgLoader.add(pic_status_six,{priority:20, id:"fir_status_six", maxTries: 1});
						imgLoader.add(pic_status_fir,{priority:20, id:"sec_status_fir", maxTries: 1});
						imgLoader.add(pic_status_sec,{priority:20, id:"sec_status_sec", maxTries: 1});
						imgLoader.add(pic_status_thi,{priority:20, id:"sec_status_thi", maxTries: 1});
						imgLoader.add(pic_status_fou,{priority:20, id:"sec_status_fou", maxTries: 1});
						imgLoader.add(pic_status_fif,{priority:20, id:"sec_status_fif", maxTries: 1});
						imgLoader.add(pic_status_six,{priority:20, id:"sec_status_six", maxTries: 1});
						imgLoader.add(pic_status_fir,{priority:20, id:"thi_status_fir", maxTries: 1});
						imgLoader.add(pic_status_sec,{priority:20, id:"thi_status_sec", maxTries: 1});
						imgLoader.add(pic_status_thi,{priority:20, id:"thi_status_thi", maxTries: 1});
						imgLoader.add(pic_status_fou,{priority:20, id:"thi_status_fou", maxTries: 1});
						imgLoader.add(pic_status_fif,{priority:20, id:"thi_status_fif", maxTries: 1});
						imgLoader.add(pic_status_six,{priority:20, id:"thi_status_six", maxTries: 1});
						imgLoader.add(no_pic,{priority:20, id:"no_pic_main", maxTries: 1});
						imgLoader.add(no_pic,{priority:20, id:"no_pic_fir", maxTries: 1});
						imgLoader.add(no_pic,{priority:20, id:"no_pic_sec", maxTries: 1});
						imgLoader.add(no_pic,{priority:20, id:"no_pic_thi", maxTries: 1});
						imgLoader.start();
						
						//xmlLoader.add("pmh" + xml_num + ".xml", {priority:20, id:"item_info", maxTries: 1});
						xmlLoader.add(base_url + "uploadFile/xml/pmh" + xml_num + ".xml", {priority:20, id:"item_info", maxTries: 1});
						//xmlLoader.add("http://wangpai.staa.com.cn/flash/xml/pmh" + xml_num + ".xml", {priority:20, id:"item_info", maxTries: 1});
						xmlLoader.addEventListener(BulkLoader.COMPLETE, onXMLItemLoaded);
            			xmlLoader.addEventListener(BulkLoader.PROGRESS, onXMLItemProgress);
						xmlLoader.addEventListener(BulkLoader.ERROR,onXMLBulkLoaderError);
						xmlLoader.start();
						
						xmlProgressBar = new ProgressBar();
						xmlProgressBar.source = xmlLoader;
						xmlProgressBar.setSize(380, 22);
						xmlProgressBar.move(320,300);
						xmlProgressBar.direction = ProgressBarDirection.RIGHT;
						xmlProgressBar.visible = true;
						xmlProgressBar.addEventListener(ProgressEvent.PROGRESS, barProgressHandler);
						xmlProgressBar.addEventListener(Event.COMPLETE, barCompleteHandler);
						addChild(xmlProgressBar);
						
						barLabel = new Label();
						barLabel.text = "";
						barLabel.autoSize = TextFieldAutoSize.LEFT;
						barLabel.move(xmlProgressBar.x+115, xmlProgressBar.y+10 + xmlProgressBar.height);
						barLabel.visible = true;
						addChild(barLabel);
					}else if(connect_status == "91"){
						if(startLoadXml_timer != null){
							startLoadXml_timer.stop();
							startLoadXml_timer.removeEventListener(TimerEvent.TIMER,startLoadXml);
						}
						if(startLoadItem_timer != null){
							startLoadItem_timer.stop();
							startLoadItem_timer.removeEventListener(TimerEvent.TIMER,startLoadItem);
						}
						if(heart_timer != null){
							heart_timer.stop();
							heart_timer.removeEventListener(TimerEvent.TIMER,heartStart);
						}
						setDefaultStatus();
						connectCloseAlertBox = new ConnectCloseAlertBox();
						connectCloseAlertBox.addEventListener("okEvent",okConnectCloseHandler);
	       				connectCloseAlertBox.addEventListener("closeEvent",closeConnectCloseHandler);
						connectCloseAlertBox.title.text = "拍卖会不存在！";
						if(videoPlayer != null){
							removeChild(videoPlayer);
						}
						pauseItemButton.visible = false;
						sqpjButton.visible = false;
						addChild(connectCloseAlertBox);
						cover.visible = true;
					}else if(connect_status == "92"){
						if(startLoadXml_timer != null){
							startLoadXml_timer.stop();
							startLoadXml_timer.removeEventListener(TimerEvent.TIMER,startLoadXml);
						}
						if(startLoadItem_timer != null){
							startLoadItem_timer.stop();
							startLoadItem_timer.removeEventListener(TimerEvent.TIMER,startLoadItem);
						}
						if(heart_timer != null){
							heart_timer.stop();
							heart_timer.removeEventListener(TimerEvent.TIMER,heartStart);
						}
						setDefaultStatus();
						connectCloseAlertBox = new ConnectCloseAlertBox();
						connectCloseAlertBox.addEventListener("okEvent",okConnectCloseHandler);
	       				connectCloseAlertBox.addEventListener("closeEvent",closeConnectCloseHandler);
						connectCloseAlertBox.title.text = "拍卖会已结束！";
						if(videoPlayer != null){
							removeChild(videoPlayer);
						}
						pauseItemButton.visible = false;
						sqpjButton.visible = false;
						addChild(connectCloseAlertBox);
						cover.visible = true;
					}else if(connect_status == "93"){
						if(startLoadXml_timer != null){
							startLoadXml_timer.stop();
							startLoadXml_timer.removeEventListener(TimerEvent.TIMER,startLoadXml);
						}
						if(startLoadItem_timer != null){
							startLoadItem_timer.stop();
							startLoadItem_timer.removeEventListener(TimerEvent.TIMER,startLoadItem);
						}
						if(heart_timer != null){
							heart_timer.stop();
							heart_timer.removeEventListener(TimerEvent.TIMER,heartStart);
						}
						setDefaultStatus();
						connectCloseAlertBox = new ConnectCloseAlertBox();
						connectCloseAlertBox.addEventListener("okEvent",okConnectCloseHandler);
	       				connectCloseAlertBox.addEventListener("closeEvent",closeConnectCloseHandler);
						connectCloseAlertBox.title.text = "无有效拍品！";
						if(videoPlayer != null){
							removeChild(videoPlayer);
						}
						pauseItemButton.visible = false;
						sqpjButton.visible = false;
						addChild(connectCloseAlertBox);
						cover.visible = true;
					}else if(connect_status == "94"){
						user_number = line_array[3];
						setAliveNum();
					}else if(connect_status == "00"){
						
						if(startLoadItem_timer != null){
							startLoadItem_timer.stop();
							startLoadItem_timer.removeEventListener(TimerEvent.TIMER,startLoadItem);
						}
						
						cover.visible = false;
						//text_barProgress.visible = false;
						if(contains(barLabel))
							removeChild(barLabel);
						barLabel.visible = false;
						if(contains(xmlProgressBar))
							removeChild(xmlProgressBar);
						xmlProgressBar.visible = false;
						
						item_id = line_array[3];
						item_index = line_array[4];
						item_page_index_flag = item_index;
						//item_order = line_array[5];
						item_valuation_method = line_array[6];
						item_count_number = line_array[7];
						item_commission_type = line_array[8];
						item_commission_value = line_array[9];
						item_margin = line_array[10];
						item_price = line_array[11];
						team_id = line_array[12];
						item_status = line_array[13];
						item_price_range = line_array[14];
						item_price_range_type = line_array[15];
						item_price_range_mode = line_array[16];
						pause_flag = line_array[17];
						price_user_id = line_array[18];
						price_user_type = line_array[19];
						price_user_bid = line_array[20];
						
						price_array = line_array[21].split("#");
						level_fir = price_array[0];
						level_sec = price_array[1];
						level_thi = price_array[2];
						level_fou = price_array[3];
						level_fif = price_array[4];
						
						com_amo_array = line_array[22].split("#");
						commission_val = com_amo_array[0];
						amount_val = com_amo_array[1];
						
						item_count = line_array[23];
						
						item_status_list = line_array[24].split("#");
						item_status_fir = item_status_list[0];
						item_status_sec = item_status_list[1];
						item_status_thi = item_status_list[2];
						
						count_time_flag = line_array[25];
						auction_status = line_array[26];
						
						xml_file = xmlLoader.getXML("item_info");
						item_name = xml_file.item.(id==item_id).itemName;
						item_count_unit = xml_file.item.(id==item_id).countUnit;
						item_count_content = xml_file.item.(id==item_id).countContent;
						item_description = xml_file.item.(id==item_id).itemDescription;
						item_pic_url = xml_file.item.(id==item_id).item_pic_url;
						item_order = xml_file.item.(id==item_id).viewOrder;
						
						setAuctionStatus();
						setDescriptionArea();
						setTitleArea();
						setControlButtonArea();
						setRangeEditArea();
						setPriceButtonValue();
						setPicList();
						setAuctionStatusList(item_index + "号拍品信息加载");
						
						heart_timer = new Timer(5000);
						heart_timer.addEventListener(TimerEvent.TIMER,heartStart);
						heart_timer.start();
						
					}else if(connect_status == "95"){
						item_id = line_array[3];
						item_index = line_array[4];
						item_page_index_flag = item_index;
						//item_order = line_array[5];
						item_valuation_method = line_array[6];
						item_count_number = line_array[7];
						item_commission_type = line_array[8];
						item_commission_value = line_array[9];
						item_margin = line_array[10];
						item_price = line_array[11];
						team_id = line_array[12];
						item_status = line_array[13];
						item_price_range = line_array[14];
						item_price_range_type = line_array[15];
						item_price_range_mode = line_array[16];
						pause_flag = line_array[17];
						price_user_id = line_array[18];
						price_user_type = line_array[19];
						price_user_bid = line_array[20];
						
						price_array = line_array[21].split("#");
						level_fir = price_array[0];
						level_sec = price_array[1];
						level_thi = price_array[2];
						level_fou = price_array[3];
						level_fif = price_array[4];
						
						com_amo_array = line_array[22].split("#");
						commission_val = com_amo_array[0];
						amount_val = com_amo_array[1];
						
						item_count = line_array[23];
						
						item_status_list = line_array[24].split("#");
						item_status_fir = item_status_list[0];
						item_status_sec = item_status_list[1];
						item_status_thi = item_status_list[2];
						
						count_time_flag = line_array[25];
						auction_status = line_array[26];
						
						//xml_file = xmlLoader.getXML("item_info");
						item_name = xml_file.item.(id==item_id).itemName;
						item_count_unit = xml_file.item.(id==item_id).countUnit;
						item_count_content = xml_file.item.(id==item_id).countContent;
						item_description = xml_file.item.(id==item_id).itemDescription;
						item_pic_url = xml_file.item.(id==item_id).item_pic_url;
						item_order = xml_file.item.(id==item_id).viewOrder;
						
						setAuctionStatus();
						setDescriptionArea();
						setTitleArea();
						setControlButtonArea();
						setRangeEditArea();
						setPriceButtonValue();
						//setAuctionStatusList();
						//setPriceDataList();
						setPicList();
					}else if(connect_status == "89"){
						auction_status = "1";
						setAuctionStatus();
						setDescriptionArea();
						setTitleArea();
						setControlButtonArea();
						setRangeEditArea();
						setPriceButtonValue();
					}else if(connect_status == "87"){
					}else if(connect_status == "01"){
						item_id_flag = line_array[3];
						if(item_id_flag != item_id){
							sendMessage("87", (item_id + "&"));
						}else{
							item_status = line_array[4];
							setTitleArea();
							setControlButtonArea();
							setRangeEditArea();
							setPriceButtonValue();
							//setPriceDataList();
							setPicStatus();
							setAuctionStatusList(item_index + "号拍品开始拍卖");
						}
					}else if(connect_status == "02"){
						item_id_flag = line_array[3];
						if(item_id_flag != item_id){
							sendMessage("87", (item_id + "&"));
						}else{
							pause_flag = line_array[4];
							
							if(count_down_timer != null){
								count_down_timer.stop();
								count_down_timer.removeEventListener(TimerEvent.TIMER,countdown);
								count_down_text.visible = false;
								countTimeButton.gotoAndStop(1);
								countTimeButton.addEventListener(MouseEvent.CLICK,countTimeHandler);
								countTimeCancelButton.gotoAndStop(2);
								countTimeCancelButton.removeEventListener(MouseEvent.CLICK,countTimeCancelHandler);
							}
							setTitleArea();
							setControlButtonArea();
							setRangeEditArea();
							setPriceButtonValue();
							//setPriceDataList();
							setPicStatus();
							setAuctionStatusList(item_index + "号拍品暂停拍卖");
						}
					}else if(connect_status == "03"){
						item_id_flag = line_array[3];
						if(item_id_flag != item_id){
							sendMessage("87", (item_id + "&"));
						}else{
							pause_flag = line_array[4];
							
							setTitleArea();
							setControlButtonArea();
							setRangeEditArea();
							setPriceButtonValue();
							//setPriceDataList();
							setPicStatus();
							setAuctionStatusList(item_index + "号拍品继续拍卖");
						}
					}else if(connect_status == "04"){
						item_id_flag = line_array[3];
						if(item_id_flag != item_id){
							sendMessage("87", (item_id + "&"));
						}else{
							item_status = line_array[4];
							price_user_type = line_array[5];
							price_user_id = line_array[6];
							price_user_bid = line_array[7];
							
							if(count_down_timer != null){
								count_down_timer.stop();
								count_down_timer.removeEventListener(TimerEvent.TIMER,countdown);
								count_down_text.visible = false;
								countTimeButton.gotoAndStop(2);
								countTimeButton.removeEventListener(MouseEvent.CLICK,countTimeHandler);
								countTimeCancelButton.gotoAndStop(2);
								countTimeCancelButton.removeEventListener(MouseEvent.CLICK,countTimeCancelHandler);
							}
							
							if(price_user_type == "1"){
								if(line_array.length == new uint(9)){
									setDealDataList();
									recordPriceButton.gotoAndStop(2); 
									recordPriceButton.label_text.text = "出价记录";
									recordPriceButton.addEventListener(MouseEvent.CLICK,recordPriceHandler);
									priceDataGrid.visible = false;
									recordDealButton.gotoAndStop(1);
									recordDealButton.label_text.text = "成交记录";
									recordDealButton.removeEventListener(MouseEvent.CLICK,recordDealHandler);
									dealDataGrid.visible = true;
								}else{
									setTitleArea();
									setControlButtonArea();
									setRangeEditArea();
									setPriceButtonValue();
									setPicStatus();
									
									setAuctionStatusList(item_index + "号拍品已成交");
								}
							}else{
								setTitleArea();
								setControlButtonArea();
								setRangeEditArea();
								setPriceButtonValue();
								setPicStatus();
								
								setDealDataList();
								recordPriceButton.gotoAndStop(2); 
								recordPriceButton.label_text.text = "出价记录";
								recordPriceButton.addEventListener(MouseEvent.CLICK,recordPriceHandler);
								priceDataGrid.visible = false;
								recordDealButton.gotoAndStop(1);
								recordDealButton.label_text.text = "成交记录";
								recordDealButton.removeEventListener(MouseEvent.CLICK,recordDealHandler);
								dealDataGrid.visible = true;
							
								setAuctionStatusList(item_index + "号拍品已成交");
							}
						}
					}else if(connect_status == "88"){
						item_id_flag = line_array[3];
						if(item_id_flag != item_id){
							sendMessage("87", (item_id + "&"));
						}else{
							item_status = line_array[4];
							price_user_type = line_array[5];
							setTitleArea();
							setControlButtonArea();
							setRangeEditArea();
							setPriceButtonValue();
							//setPriceDataList();
							setPicStatus();
							setAuctionStatusList(item_index + "号拍品撤销成交");
						}
					}else if(connect_status == "05"){
						item_id_flag = line_array[3];
						if(item_id_flag != item_id){
							sendMessage("87", (item_id + "&"));
						}else{
							item_status = line_array[4];
							if(count_down_timer != null){
								count_down_timer.stop();
								count_down_timer.removeEventListener(TimerEvent.TIMER,countdown);
								count_down_text.visible = false;
								countTimeButton.gotoAndStop(2);
								countTimeButton.removeEventListener(MouseEvent.CLICK,countTimeHandler);
								countTimeCancelButton.gotoAndStop(2);
								countTimeCancelButton.removeEventListener(MouseEvent.CLICK,countTimeCancelHandler);
							}
							setTitleArea();
							setControlButtonArea();
							setRangeEditArea();
							setPriceButtonValue();
							//setPriceDataList();
							setPicStatus();
							setAuctionStatusList(item_index + "号拍品流标");
						}
					}else if(connect_status == "06"){
						item_id_flag = line_array[3];
						if(item_id_flag != item_id){
							sendMessage("87", (item_id + "&"));
						}else{
							item_status = line_array[4];
							price_user_type = line_array[5];
							
							price_array = line_array[8].split("#");
							level_fir = price_array[0];
							level_sec = price_array[1];
							level_thi = price_array[2];
							level_fou = price_array[3];
							level_fif = price_array[4];
							
							com_amo_array = line_array[9].split("#");
							commission_val = com_amo_array[0];
							amount_val = com_amo_array[1];
							
							setTitleArea();
							setControlButtonArea();
							setRangeEditArea();
							setPriceButtonValue();
							//setPriceDataList();
							setPicStatus();
							priceDataProvider.removeAll();
							setAuctionStatusList(item_index + "号拍品重新拍卖");
						}
					}else if(connect_status == "07"){
						item_id = line_array[3];
						item_index = line_array[4];
						item_page_index_flag = item_index;
						//item_order = line_array[5];
						item_valuation_method = line_array[6];
						item_count_number = line_array[7];
						item_commission_type = line_array[8];
						item_commission_value = line_array[9];
						item_margin = line_array[10];
						item_price = line_array[11];
						team_id = line_array[12];
						item_status = line_array[13];
						item_price_range = line_array[14];
						item_price_range_type = line_array[15];
						item_price_range_mode = line_array[16];
						pause_flag = line_array[17];
						price_user_id = line_array[18];
						price_user_type = line_array[19];
						price_user_bid = line_array[20];
						
						price_array = line_array[21].split("#");
						level_fir = price_array[0];
						level_sec = price_array[1];
						level_thi = price_array[2];
						level_fou = price_array[3];
						level_fif = price_array[4];
						
						com_amo_array = line_array[22].split("#");
						commission_val = com_amo_array[0];
						amount_val = com_amo_array[1];
						
						item_count = line_array[23];
						
						item_status_list = line_array[24].split("#");
						item_status_fir = item_status_list[0];
						item_status_sec = item_status_list[1];
						item_status_thi = item_status_list[2];
						
						count_time_flag = line_array[25];
						auction_status = line_array[26];
						
						item_name = xml_file.item.(id==item_id).itemName;
						item_count_unit = xml_file.item.(id==item_id).countUnit;
						item_count_content = xml_file.item.(id==item_id).countContent;
						item_description = xml_file.item.(id==item_id).itemDescription;
						item_pic_url = xml_file.item.(id==item_id).item_pic_url;
						item_order = xml_file.item.(id==item_id).viewOrder;
						
						setAuctionStatus();
						setDescriptionArea();
						setTitleArea();
						setControlButtonArea();
						setRangeEditArea();
						setPriceButtonValue();
						//setAuctionStatusList();
						setPicList();
						priceDataProvider.removeAll();
						setAuctionStatusList(item_index + "号拍品加载信息");
					}else if(connect_status == "08"){
						item_id_flag = line_array[3];
						if(item_id_flag != item_id){
							sendMessage("87", (item_id + "&"));
						}else{
							item_status = line_array[4];
							price_user_type = line_array[5];
							price_user_id = line_array[6];
							price_user_bid = line_array[7];
							
							price_array = line_array[8].split("#");
							level_fir = price_array[0];
							level_sec = price_array[1];
							level_thi = price_array[2];
							level_fou = price_array[3];
							level_fif = price_array[4];
							
							com_amo_array = line_array[9].split("#");
							commission_val = com_amo_array[0];
							amount_val = com_amo_array[1];
							
							if(count_down_timer != null){
								count_down_timer.stop();
								count_down_timer.removeEventListener(TimerEvent.TIMER,countdown);
								count_down_text.visible = false;
								countTimeButton.gotoAndStop(1);
								countTimeButton.addEventListener(MouseEvent.CLICK,countTimeHandler);
								countTimeCancelButton.gotoAndStop(2);
								countTimeCancelButton.removeEventListener(MouseEvent.CLICK,countTimeCancelHandler);
							}
							
							setTitleArea();
							setControlButtonArea();
							//setAuctionStatusList();
							//setPicList();
							setPriceButtonValue();
							setAuctionStatusList(item_index + "号拍品恢复上一价格:" + level_fir);
						}
					}else if(connect_status == "09"){
						item_id_flag = line_array[3];
						if(item_id_flag != item_id){
							sendMessage("87", (item_id + "&"));
						}else{
							item_status = line_array[4];
							itemStatus.text = "倒计时";
							
							count_down_time = new uint(count_time_flag);
							count_down_timer = new Timer(1000,(count_down_time+1));
							count_down_timer.addEventListener(TimerEvent.TIMER,countdown);
							count_down_timer.start();
							
							countTimeCancelButton.gotoAndStop(1);
							countTimeCancelButton.addEventListener(MouseEvent.CLICK,countTimeCancelHandler)
							//setPriceDataList();
							setAuctionStatusList(item_index + "号拍品网络倒计时");
						}
					}else if(connect_status == "10"){
						item_id_flag = line_array[3];
						if(item_id_flag != item_id){
							sendMessage("87", (item_id + "&"));
						}else{
							item_status = line_array[4];
							setTitleArea();
							
							if(count_down_timer != null){
								count_down_timer.stop();
								count_down_timer.removeEventListener(TimerEvent.TIMER,countdown);
								count_down_text.visible = false;
								countTimeButton.gotoAndStop(1);
								countTimeButton.addEventListener(MouseEvent.CLICK,countTimeHandler);
							}
							//setPriceDataList();
							setAuctionStatusList(item_index + "号拍品取消网络倒计时");
						}
					}else if(connect_status == "11"){
						item_id_flag = line_array[3];
						if(item_id_flag != item_id){
							sendMessage("87", (item_id + "&"));
						}else{
							item_price_range = line_array[4]
							item_price_range_type = line_array[5]
							item_price_range_mode = line_array[6]
								
							price_array = line_array[7].split("#");
							level_fir = price_array[0];
							level_sec = price_array[1];
							level_thi = price_array[2];
							level_fou = price_array[3];
							level_fif = price_array[4];
							
							setControlButtonArea();
							setRangeEditArea();
							setPriceButtonValue();
							//setPriceDataList();
							setAuctionStatusList(item_index + "号拍品切换报价模式");
						}
					}else if(connect_status == "12"){
						item_id_flag = line_array[3];
						if(item_id_flag != item_id){
							sendMessage("87", (item_id + "&"));
						}else{
							item_price_range = line_array[4];
							price_array = line_array[5].split("#");
							level_fir = price_array[0];
							level_sec = price_array[1];
							level_thi = price_array[2];
							level_fou = price_array[3];
							level_fif = price_array[4];
							
							setControlButtonArea();
							setRangeEditArea();
							setPriceButtonValue();
							//setPriceDataList();
							setAuctionStatusList(item_index + "号拍品切换固定模式幅度");
						}
					}else if(connect_status == "13"){
						item_id_flag = line_array[3];
						if(item_id_flag != item_id){
							sendMessage("87", (item_id + "&"));
						}else{
							item_price_range_mode = line_array[4];
							price_array = line_array[5].split("#");
							level_fir = price_array[0];
							level_sec = price_array[1];
							level_thi = price_array[2];
							level_fou = price_array[3];
							level_fif = price_array[4];
							
							setControlButtonArea();
							setRangeEditArea();
							setPriceButtonValue();
							//setPriceDataList();
							setAuctionStatusList(item_index + "号拍品切换250,258模式幅度");
						}
					}else if(connect_status == "14"){
						item_id_flag = line_array[3];
						if(item_id_flag != item_id){
							sendMessage("87", (item_id + "&"));
						}else{
							count_time_flag = line_array[4];
							djssd_input.text = "" + count_time_flag;
							djssdButton.gotoAndStop(1);
							djssdButton.addEventListener(MouseEvent.CLICK,djssdHandler);
							setAuctionStatusList("倒计时时间改为:" + count_time_flag);
						}
					}else if(connect_status == "15"){
						item_id_flag = line_array[3];
						if(item_id_flag != item_id){
							sendMessage("87", (item_id + "&"));
						}else{
							item_status = line_array[4];
							setDescriptionArea();
							setTitleArea();
							setControlButtonArea();
							setRangeEditArea();
							setPriceButtonValue();
							//setAuctionStatusList();
							//setPriceDataList();
							//setPicList();
							setAuctionStatusList(item_index + "号拍品撤拍");
						}
					}else if(connect_status == "16"){
						item_id_flag = line_array[3];
						if(item_id_flag != item_id){
							sendMessage("87", (item_id + "&"));
						}else{
							item_status = line_array[4];
							setDescriptionArea();
							setTitleArea();
							setControlButtonArea();
							setRangeEditArea();
							setPriceButtonValue();
							//setAuctionStatusList();
							//setPriceDataList();
							//setPicList();
							setAuctionStatusList(item_index + "号拍品缓拍");
						}
					}else if(connect_status == "21"){
						item_id_flag = line_array[3];
						if(item_id_flag != item_id){
							sendMessage("87", (item_id + "&"));
						}else{
							item_price = line_array[4];
							price_array = line_array[5].split("#");
							level_fir = price_array[0];
							level_sec = price_array[1];
							level_thi = price_array[2];
							level_fou = price_array[3];
							level_fif = price_array[4];
							
							itemPrice.text = "起拍价格: " + item_price;
							setTitleArea();
							setPriceButtonValue();
							setControlButtonArea();
							//setAuctionStatusList();
							//setPriceDataList();
							//setPicList();
						}
					}else if(connect_status == "22"){
						item_id_flag = line_array[3];
						if(item_id_flag != item_id){
							sendMessage("87", (item_id + "&"));
						}else{
							item_page_index_flag = line_array[4]
							item_status_list = line_array[5].split("#");
							item_status_fir = item_status_list[0];
							item_status_sec = item_status_list[1];
							item_status_thi = item_status_list[2];
							
							setPicList();
						}
					}else if(connect_status == "31"){
						item_id_flag = line_array[3];
						if(item_id_flag != item_id){
							sendMessage("87", (item_id + "&"));
						}else{
							item_status = line_array[4];
							price_user_type = line_array[5];
							price_user_id = line_array[6];
							price_user_bid = line_array[7];
							
							price_array = line_array[8].split("#");
							level_fir = price_array[0];
							level_sec = price_array[1];
							level_thi = price_array[2];
							level_fou = price_array[3];
							level_fif = price_array[4];
							
							com_amo_array = line_array[9].split("#");
							commission_val = com_amo_array[0];
							amount_val = com_amo_array[1];
							
							if(count_down_timer != null){
								count_down_timer.stop();
								count_down_timer.removeEventListener(TimerEvent.TIMER,countdown);
								count_down_text.visible = false;
								countTimeButton.gotoAndStop(1);
								countTimeButton.addEventListener(MouseEvent.CLICK,countTimeHandler);
								countTimeCancelButton.gotoAndStop(2);
								countTimeCancelButton.removeEventListener(MouseEvent.CLICK,countTimeCancelHandler);
							}
							
							setTitleArea();
							setControlButtonArea();
							//setAuctionStatusList();
							setPriceDataList();
							//setPicList();
							setPriceButtonValue();
							recordPriceButton.gotoAndStop(1); 
							recordPriceButton.label_text.text = "出价记录";
							recordPriceButton.removeEventListener(MouseEvent.CLICK,recordPriceHandler);
							priceDataGrid.visible = true;
							recordDealButton.gotoAndStop(2);
							recordDealButton.label_text.text = "成交记录";
							recordDealButton.addEventListener(MouseEvent.CLICK,recordDealHandler);
							dealDataGrid.visible = false;
						}
					}
					
					
				}
				line = line.slice(line.indexOf("uee_n_d") + 7);
			}
			
			
		}
		
		public function heartStart(e:TimerEvent):void{
			if(heart_counter != 0){
				sendMessage("87", (item_id + "&"));
				heart_counter--;
			}else{
				//...心跳结束处理断开连接提示
				socket.close();
			}
			
			if(contains(barLabel))
				removeChild(barLabel);
			barLabel.visible = false;
			if(contains(xmlProgressBar))
				removeChild(xmlProgressBar);
			xmlProgressBar.visible = false;
				
		}
		
		private function setAuctionStatus(){
			if( auction_status == "0" ){
				auctionStatus.text = "拍卖会尚未开始";
			}else if( auction_status == "1" ){
				auctionStatus.text = "拍卖会正在进行";
			}else if( auction_status == "2" ){
				auctionStatus.text = "拍卖会已经结束";
			}
		}
		
		private function setAliveNum(){
			aliveNum.text = "当前在线:" + user_number + "人";
		}
		
		private function setDescriptionArea(){
			//showMedia.addEventListener(MouseEvent.CLICK,fnCallJs);
			videoButton.addEventListener(MouseEvent.CLICK, stratVideoHandler);
			
			var request:URLRequest = new URLRequest(item_pic_url.substr(1,item_pic_url.length));
            item_image.load(request);
			item_image.addEventListener(IOErrorEvent.IO_ERROR, ioErrorImgHandler);
			/*request = new URLRequest("nopic.jpg");
			item_image_nopic.load(request);*/
			item_image_nopic.source = imgLoader.getContent("no_pic_main");
			item_image_nopic.visible = false;
			
			itemName.text = "拍品名称:" + item_name; 
			itemPrice.text = "起拍价格: " + item_price;
			if(item_commission_type == "1"){
				itemCommissionType.text = "佣金标准:固定比例"; 
				itemCommissionValue.text = "佣金标准:固定比例";
				itemCommissionPrice.text = "佣金金额:" + item_commission_value + "%";
			}else if(item_commission_type == "2"){
				itemCommissionType.text = "佣金标准:定额佣金";
				itemCommissionValue.text = "佣金标准:定额佣金";
				itemCommissionPrice.text = "佣金金额:" + item_commission_value + "元";
			}else if(item_commission_type == "3"){
				itemCommissionType.text = "佣金标准:司法规定";
				itemCommissionValue.text = "佣金标准:司法规定";
				itemCommissionPrice.text = "佣金金额:司法规定";
			}
			
			if(item_count_unit == "1"){
				itemUnit.text = "数量/单位:" + item_count_number + "/件"; 
				itemCount.text = "元/件";
			}else if(item_count_unit == "2"){
				itemUnit.text = "数量/单位:" + item_count_number + "/台";
				itemCount.text = "元/台";
			}else if(item_count_unit == "3"){
				itemUnit.text = "数量/单位:" + item_count_number + "/个";
				itemCount.text = "元/个";
			}else if(item_count_unit == "4"){
				itemUnit.text = "数量/单位:" + item_count_number + "/批";
				itemCount.text = "元/批";
			}else if(item_count_unit == "5"){
				itemUnit.text = "数量/单位:" + item_count_number + "/组";
				itemCount.text = "元/组";
			}else if(item_count_unit == "6"){
				itemUnit.text = "数量/单位:" + item_count_number + "/平方米";
				itemCount.text = "元/平方米";
			}else if(item_count_unit == "7"){
				itemUnit.text = "数量/单位:" + item_count_number + "/吨";
				itemCount.text = "元/吨";
			}else if(item_count_unit == "8"){
				itemUnit.text = "数量/单位:" + item_count_number + "/公斤";
				itemCount.text = "元/公斤";
			}else if(item_count_unit == "9"){
				itemUnit.text = "数量/单位:" + item_count_number + "/股";
				itemCount.text = "元/股";
			}else if(item_count_unit == "10"){
				itemUnit.text = "数量/单位:" + item_count_number + "/辆";
				itemCount.text = "元/辆";
			}else if(item_count_unit == "11"){
				itemUnit.text = "数量/单位:" + item_count_number + "/" + item_count_content;
				itemCount.text = "元/" + item_count_content;
			}
			
			if(item_valuation_method == "1"){
				itemValuationMethod.text = "计价方式:总价";
				itemValuationType.text = "";
				itemCount.text = "元";
				//itemCount.visible = false;
			}else  if(item_valuation_method == "2"){
				itemValuationMethod.text = "计价方式:单价"; 
				itemValuationType.text = "单价";
				//itemCount.visible = true;
			}
			
			itemMargin.text = "需保证金:" + item_margin + "元";
			
			itemDescription.htmlText = "<span><font size='14' color='#333333' face='宋体'>" + item_description + "</font></span>";
			
			auctionName.text = item_order + "号拍品最新出价";
			
		}
		private function stratVideoHandler(event:MouseEvent):void {
			if(videoPlayer != null){
				videoPlayer.x = 160;
				videoPlayer.y = 160;
			}else{
				videoPlayer = new VideoPlayer();
				videoPlayer.onVideoLoad(serverURL, videoURL);
				videoPlayer.x = 160;
				videoPlayer.y = 160;
				videoPlayer.addEventListener(MouseEvent.MOUSE_DOWN, videoBtnMouseDown);
				//videoPlayer.addEventListener("okEvent",okDealResultHandler);
				videoPlayer.addEventListener("closeEvent",closeVideoHandler);
				videoPlayer.addEventListener(MouseEvent.MOUSE_UP, videoBtnMouseReleased);
				addChild(videoPlayer);
			}
		}
		private function closeVideoHandler(evt:Event):void {	
			videoPlayer = null;
			cleanVideoInput(evt);
	    }
		private function cleanVideoInput(evt:Event):void{
	      //evt.currentTarget.removeEventListener("okEvent",okDealResultHandler);
	      evt.currentTarget.removeEventListener("closeEvent",closeVideoHandler);	
	      removeChild(evt.currentTarget as DisplayObject);
	    }
		private function videoBtnMouseDown(event:MouseEvent):void {
			videoPlayer.startDrag();
		}
		private function videoBtnMouseReleased(event:MouseEvent):void {
			videoPlayer.stopDrag();
		}
		private function fnCallJs(e:MouseEvent):void { 
			//ExternalInterface.call("JsHello");  
		}
		private function ioErrorImgHandler(e:IOErrorEvent):void {
			item_image_nopic.visible = true;
		}
		
		private function setTitleArea(){
			itemTotalPrice.text = "含佣金总价:" + amount_val + "元";
			
			var current_val_integer:String = "";
			var current_val_dicemal:String = "";
			var current_val_head:String = "";
			var current_val_end:String = "";
			if(level_fir.indexOf(".") != -1){
				current_val_integer = level_fir.substr(0,level_fir.indexOf("."));
				current_val_dicemal = level_fir.substr(level_fir.indexOf("."));
			}else {
				current_val_integer = level_fir;
			}
			if(price_user_type == "1"){
				priceStatusAlive.gotoAndStop(1);
				priceStatusAlive.typeTitle.htmlText = "现场出价";
				priceStatusWeb.gotoAndStop(2);
				priceStatusWeb.typeTitle.htmlText = "网络出价";
				if(current_val_integer.length > 4){
					current_val_head = current_val_integer.substr(0,current_val_integer.length-4);
					current_val_end = current_val_integer.substr(current_val_integer.length-4,current_val_integer.length) + current_val_dicemal;
					itemCurrentPrice.htmlText = "<b><font color='#00FFFF' size='64'>" + current_val_head + 
						"</font></b><b><font color='#00FFFF' size='50'>" + current_val_end + "</font></b>";
				}else{
					itemCurrentPrice.htmlText = "<b><font color='#00FFFF' size='64' face='Arial'>" + level_fir + "</font></b>"; 
				}
			}else if(price_user_type == "2"){
				priceStatusAlive.gotoAndStop(2);
				priceStatusAlive.typeTitle.htmlText = "现场出价";
				priceStatusWeb.gotoAndStop(1);
				priceStatusWeb.typeTitle.htmlText = "网络出价";
				if(current_val_integer.length > 4){
					current_val_head = current_val_integer.substr(0,current_val_integer.length-4);
					current_val_end = current_val_integer.substr(current_val_integer.length-4,current_val_integer.length) + current_val_dicemal;
					itemCurrentPrice.htmlText = "<b><font color='#FFF000' size='64'>" + current_val_head + 
						"</font></b><b><font color='#FFF000' size='50'>" + current_val_end + "</font></b>";
				}else{
					itemCurrentPrice.htmlText = "<b><font color='#FFF000' size='64' face='Arial'>" + level_fir + "</font></b>"; 
				}
			}else{
				priceStatusAlive.gotoAndStop(2);
				priceStatusAlive.typeTitle.htmlText = "现场出价";
				priceStatusWeb.gotoAndStop(2);
				priceStatusWeb.typeTitle.htmlText = "网络出价";
				if(current_val_integer.length > 4){
					current_val_head = current_val_integer.substr(0,current_val_integer.length-4);
					current_val_end = current_val_integer.substr(current_val_integer.length-4,current_val_integer.length) + current_val_dicemal;
					itemCurrentPrice.htmlText = "<b><font color='#FFFFFF' size='64'>" + current_val_head + 
						"</font></b><b><font color='#FFFFFF' size='50'>" + current_val_end + "</font></b>";
				}else{
					itemCurrentPrice.htmlText = "<b><font color='#FFFFFF' size='64' face='Arial'>" + level_fir + "</font></b>"; 
				}
			}
			
			if(item_status == "0"){
				itemStatus.text = "尚未开始";
			}else if(item_status == "1"){
				itemStatus.text = "正在进行";
			}else if(item_status == "2"){
				itemStatus.text = "正在进行";
			}else if(item_status == "3"){
				itemStatus.text = "正在进行";
			}else if(item_status == "4"){
				itemStatus.text = "网络关闭";
			}else if(item_status == "5"){
				itemStatus.text = "成  交";
			}else if(item_status == "6"){
				itemStatus.text = "流  标";
				itemCurrentPrice.htmlText = "<font color='#FFF000' size='50' face='黑体'>流标</font>"; 
			}else if(item_status == "7"){
				itemStatus.text = "撤  拍";
				itemCurrentPrice.htmlText = "<font color='#FFF000' size='50' face='黑体'>撤拍</font>"; 
			}else if(item_status == "8"){
				itemStatus.text = "缓  拍";
				itemCurrentPrice.htmlText = "<font color='#FFF000' size='50' face='黑体'>缓拍</font>"; 
			}
			
			if(pause_flag == "1"){
				itemStatus.text = "暂  停";
			}
		}
		
		private function setControlButtonArea(){
			if(contains(continueItemButton))
				removeChild(continueItemButton);
			if(contains(pauseItemButton))
				removeChild(pauseItemButton);
			if(contains(sqpjButton))
				removeChild(sqpjButton);
			if(contains(sdcjButton))
				removeChild(sdcjButton);
			
			if(item_count == item_index){
				nextItemButton.label_text.htmlText = "结束拍卖会";
			}else{
				nextItemButton.label_text.htmlText = "准备下一拍品";
			}
			
			if(auction_status == "0"){
				returnPriceButton.gotoAndStop(2);
				returnPriceButton.removeEventListener(MouseEvent.CLICK,returnPriceHandler);
				countTimeButton.gotoAndStop(2);
				countTimeButton.removeEventListener(MouseEvent.CLICK,countTimeHandler);
				startButton.gotoAndStop(2);
				startButton.removeEventListener(MouseEvent.CLICK,startHandler);
				dealButton.gotoAndStop(2);
				dealButton.removeEventListener(MouseEvent.CLICK,dealHandler);
				bidFailureButton.gotoAndStop(2);
				bidFailureButton.removeEventListener(MouseEvent.CLICK,bidFailureHandler);
				
				if(nextItemButton.label_text.text == "结束拍卖会"){
					nextItemButton.gotoAndStop(2);
					nextItemButton.removeEventListener(MouseEvent.CLICK,nextItemHandler);
				}else{
					nextItemButton.gotoAndStop(1);
					nextItemButton.addEventListener(MouseEvent.CLICK,nextItemHandler);
				}
				redoItemButton.gotoAndStop(2);
				redoItemButton.removeEventListener(MouseEvent.CLICK,redoItemHandler);
				continueItemButton.gotoAndStop(2);
				continueItemButton.removeEventListener(MouseEvent.CLICK,continueItemHandler);
				pauseItemButton.gotoAndStop(2);
				pauseItemButton.removeEventListener(MouseEvent.CLICK,pauseItemHandler);
				addChild(pauseItemButton);
				
				currentPriceButton.gotoAndStop(2);
				currentPriceButton.removeEventListener(MouseEvent.CLICK,currentPriceHandler);
				currentPriceFirButton.gotoAndStop(2);
				currentPriceFirButton.removeEventListener(MouseEvent.CLICK,currentPriceFirHandler);
				currentPriceSecButton.gotoAndStop(2);
				currentPriceSecButton.removeEventListener(MouseEvent.CLICK,currentPriceSecHandler);
				currentPriceThiButton.gotoAndStop(2);
				currentPriceThiButton.removeEventListener(MouseEvent.CLICK,currentPriceThiHandler);
				currentPriceFouButton.gotoAndStop(2);
				currentPriceFouButton.removeEventListener(MouseEvent.CLICK,currentPriceFouHandler);
				if(item_status == "0"){
					bidDelayButton.gotoAndStop(1);
					bidDelayButton.addEventListener(MouseEvent.CLICK,bidDelayHandler);
					bidCancelButton.gotoAndStop(1);
					bidCancelButton.addEventListener(MouseEvent.CLICK,bidCancelHandler);
				}else{
					bidDelayButton.gotoAndStop(2);
					bidDelayButton.removeEventListener(MouseEvent.CLICK,bidDelayHandler);
					bidCancelButton.gotoAndStop(2);
					bidCancelButton.removeEventListener(MouseEvent.CLICK,bidCancelHandler);
				}
				dealCancelButton.gotoAndStop(2);
				dealCancelButton.removeEventListener(MouseEvent.CLICK,dealCancelHandler);
				auctionStartButton.gotoAndStop(1);
				auctionStartButton.addEventListener(MouseEvent.CLICK,auctionStartHandler);
				
				if( item_status == "0" || item_status == "1" || item_status == "2"
					   || item_status == "3" || item_status == "4" ){
					if(item_price_range_type =="1"){
						gdbj_radio.selected = true;
						gdbj_radio.enabled = true;
						gdbj_radio.removeEventListener(MouseEvent.CLICK,gdbjHandler);
						ewlbj_radio.enabled = true;
						ewlbj_radio.addEventListener(MouseEvent.CLICK,ewlbjHandler);
						ewbbj_radio.enabled = true;
						ewbbj_radio.addEventListener(MouseEvent.CLICK,ewbbjHandler);
						jfbj_radio.enabled = true;
						jfbj_radio.addEventListener(MouseEvent.CLICK,jfbjHandler);
						
						gdbjFirButton.gotoAndStop(1);
						gdbjFirButton.addEventListener(MouseEvent.CLICK,gdbjFirHandler);
						gdbjSecButton.gotoAndStop(1);
						gdbjSecButton.addEventListener(MouseEvent.CLICK,gdbjSecHandler);
						gdbjThiButton.gotoAndStop(1);
						gdbjThiButton.addEventListener(MouseEvent.CLICK,gdbjThiHandler);
						gdbjFouButton.gotoAndStop(1);
						gdbjFouButton.addEventListener(MouseEvent.CLICK,gdbjFouHandler);
						gdbjFifButton.gotoAndStop(1);
						gdbjFifButton.addEventListener(MouseEvent.CLICK,gdbjFifHandler);
						gdbjSixButton.gotoAndStop(1);
						gdbjSixButton.addEventListener(MouseEvent.CLICK,gdbjSixHandler);
						gdbjSevButton.gotoAndStop(1);
						gdbjSevButton.addEventListener(MouseEvent.CLICK,gdbjSevHandler);
						
						sdbjzs_input.editable = true;
						sdbjzs_input.addEventListener(KeyboardEvent.KEY_UP, sdbjzsInput);
						sdbjxs_input.editable = false;
						sdbjxs_input.removeEventListener(KeyboardEvent.KEY_UP, sdbjxsInput);
						bjszButton.gotoAndStop(1);
						bjszButton.addEventListener(MouseEvent.CLICK,bjszHandler);
						
						sdbjFirButton.gotoAndStop(1);
						sdbjFirButton.alpha = 0.5;
						sdbjFirButton.removeEventListener(MouseEvent.CLICK,sdbjFirHandler);
						sdbjSecButton.gotoAndStop(1);
						sdbjSecButton.alpha = 0.5;
						sdbjSecButton.removeEventListener(MouseEvent.CLICK,sdbjSecHandler);
						sdbjThiButton.gotoAndStop(1);
						sdbjThiButton.alpha = 0.5;
						sdbjThiButton.removeEventListener(MouseEvent.CLICK,sdbjThiHandler);
						sdbjFouButton.gotoAndStop(1);
						sdbjFouButton.alpha = 0.5;
						sdbjFouButton.removeEventListener(MouseEvent.CLICK,sdbjFouHandler);
						sdbjFifButton.gotoAndStop(1);
						sdbjFifButton.alpha = 0.5;
						sdbjFifButton.removeEventListener(MouseEvent.CLICK,sdbjFifHandler);
						sdbjSixButton.gotoAndStop(1);
						sdbjSixButton.alpha = 0.5;
						sdbjSixButton.removeEventListener(MouseEvent.CLICK,sdbjSixHandler);
					}else if(item_price_range_type == "2"){
						ewlbj_radio.selected = true;
						gdbj_radio.enabled = true;
						gdbj_radio.addEventListener(MouseEvent.CLICK,gdbjHandler);
						ewlbj_radio.enabled = true;
						ewlbj_radio.removeEventListener(MouseEvent.CLICK,ewlbjHandler);
						ewbbj_radio.enabled = true;
						ewbbj_radio.addEventListener(MouseEvent.CLICK,ewbbjHandler);
						jfbj_radio.enabled = true;
						jfbj_radio.addEventListener(MouseEvent.CLICK,jfbjHandler);
						
						gdbjFirButton.gotoAndStop(2);
						gdbjFirButton.removeEventListener(MouseEvent.CLICK,gdbjFirHandler);
						gdbjSecButton.gotoAndStop(2);
						gdbjSecButton.removeEventListener(MouseEvent.CLICK,gdbjSecHandler);
						gdbjThiButton.gotoAndStop(2);
						gdbjThiButton.removeEventListener(MouseEvent.CLICK,gdbjThiHandler);
						gdbjFouButton.gotoAndStop(2);
						gdbjFouButton.removeEventListener(MouseEvent.CLICK,gdbjFouHandler);
						gdbjFifButton.gotoAndStop(2);
						gdbjFifButton.removeEventListener(MouseEvent.CLICK,gdbjFifHandler);
						gdbjSixButton.gotoAndStop(2);
						gdbjSixButton.removeEventListener(MouseEvent.CLICK,gdbjSixHandler);
						gdbjSevButton.gotoAndStop(2);
						gdbjSevButton.removeEventListener(MouseEvent.CLICK,gdbjSevHandler);
						
						sdbjzs_input.editable = false;
						sdbjzs_input.removeEventListener(KeyboardEvent.KEY_UP, sdbjzsInput);
						sdbjxs_input.editable = false;
						sdbjxs_input.removeEventListener(KeyboardEvent.KEY_UP, sdbjxsInput);
						bjszButton.gotoAndStop(2);
						bjszButton.removeEventListener(MouseEvent.CLICK,bjszHandler);
						
						sdbjFirButton.gotoAndStop(1);
						sdbjFirButton.addEventListener(MouseEvent.CLICK,sdbjFirHandler);
						sdbjSecButton.gotoAndStop(1);
						sdbjSecButton.addEventListener(MouseEvent.CLICK,sdbjSecHandler);
						sdbjThiButton.gotoAndStop(1);
						sdbjThiButton.addEventListener(MouseEvent.CLICK,sdbjThiHandler);
						sdbjFouButton.gotoAndStop(1);
						sdbjFouButton.addEventListener(MouseEvent.CLICK,sdbjFouHandler);
						sdbjFifButton.gotoAndStop(1);
						sdbjFifButton.addEventListener(MouseEvent.CLICK,sdbjFifHandler);
						sdbjSixButton.gotoAndStop(1);
						sdbjSixButton.addEventListener(MouseEvent.CLICK,sdbjSixHandler);
						if(item_price_range_mode == "1"){
							sdbjFirButton.gotoAndStop(2);
							sdbjFirButton.alpha = 1;
						}else if(item_price_range_mode == "2"){
							sdbjSecButton.gotoAndStop(2);
							sdbjSecButton.alpha = 1;
						}else if(item_price_range_mode == "3"){
							sdbjThiButton.gotoAndStop(2);
							sdbjThiButton.alpha = 1;
						}else if(item_price_range_mode == "4"){
							sdbjFouButton.gotoAndStop(2);
							sdbjFouButton.alpha = 1;
						}else if(item_price_range_mode == "5"){
							sdbjFifButton.gotoAndStop(2);
							sdbjFifButton.alpha = 1;
						}else if(item_price_range_mode == "6"){
							sdbjSixButton.gotoAndStop(2);
							sdbjSixButton.alpha = 1;
						}
					}else if(item_price_range_type == "3"){
						ewbbj_radio.selected = true;
						gdbj_radio.enabled = true;
						gdbj_radio.addEventListener(MouseEvent.CLICK,gdbjHandler);
						ewlbj_radio.enabled = true;
						ewlbj_radio.addEventListener(MouseEvent.CLICK,ewlbjHandler);
						ewbbj_radio.enabled = true;
						ewbbj_radio.removeEventListener(MouseEvent.CLICK,ewbbjHandler);
						jfbj_radio.enabled = true;
						jfbj_radio.addEventListener(MouseEvent.CLICK,jfbjHandler);
						
						gdbjFirButton.gotoAndStop(2);
						gdbjFirButton.removeEventListener(MouseEvent.CLICK,gdbjFirHandler);
						gdbjSecButton.gotoAndStop(2);
						gdbjSecButton.removeEventListener(MouseEvent.CLICK,gdbjSecHandler);
						gdbjThiButton.gotoAndStop(2);
						gdbjThiButton.removeEventListener(MouseEvent.CLICK,gdbjThiHandler);
						gdbjFouButton.gotoAndStop(2);
						gdbjFouButton.removeEventListener(MouseEvent.CLICK,gdbjFouHandler);
						gdbjFifButton.gotoAndStop(2);
						gdbjFifButton.removeEventListener(MouseEvent.CLICK,gdbjFifHandler);
						gdbjSixButton.gotoAndStop(2);
						gdbjSixButton.removeEventListener(MouseEvent.CLICK,gdbjSixHandler);
						gdbjSevButton.gotoAndStop(2);
						gdbjSevButton.removeEventListener(MouseEvent.CLICK,gdbjSevHandler);
						
						sdbjzs_input.editable = false;
						sdbjzs_input.removeEventListener(KeyboardEvent.KEY_UP, sdbjzsInput);
						sdbjxs_input.editable = false;
						sdbjxs_input.removeEventListener(KeyboardEvent.KEY_UP, sdbjxsInput);
						bjszButton.gotoAndStop(2);
						bjszButton.removeEventListener(MouseEvent.CLICK,bjszHandler);
						
						sdbjFirButton.gotoAndStop(1);
						sdbjFirButton.addEventListener(MouseEvent.CLICK,sdbjFirHandler);
						sdbjSecButton.gotoAndStop(1);
						sdbjSecButton.addEventListener(MouseEvent.CLICK,sdbjSecHandler);
						sdbjThiButton.gotoAndStop(1);
						sdbjThiButton.addEventListener(MouseEvent.CLICK,sdbjThiHandler);
						sdbjFouButton.gotoAndStop(1);
						sdbjFouButton.addEventListener(MouseEvent.CLICK,sdbjFouHandler);
						sdbjFifButton.gotoAndStop(1);
						sdbjFifButton.addEventListener(MouseEvent.CLICK,sdbjFifHandler);
						sdbjSixButton.gotoAndStop(1);
						sdbjSixButton.addEventListener(MouseEvent.CLICK,sdbjSixHandler);
						if(item_price_range_mode == "1"){
							sdbjFirButton.gotoAndStop(2);
							sdbjFirButton.alpha = 1;
						}else if(item_price_range_mode == "2"){
							sdbjSecButton.gotoAndStop(2);
							sdbjSecButton.alpha = 1;
						}else if(item_price_range_mode == "3"){
							sdbjThiButton.gotoAndStop(2);
							sdbjThiButton.alpha = 1;
						}else if(item_price_range_mode == "4"){
							sdbjFouButton.gotoAndStop(2);
							sdbjFouButton.alpha = 1;
						}else if(item_price_range_mode == "5"){
							sdbjFifButton.gotoAndStop(2);
							sdbjFifButton.alpha = 1;
						}else if(item_price_range_mode == "6"){
							sdbjSixButton.gotoAndStop(2);
							sdbjSixButton.alpha = 1;
						}
					}else if(item_price_range_type == "4"){
						jfbj_radio.selected = true;
						gdbj_radio.enabled = true;
						gdbj_radio.addEventListener(MouseEvent.CLICK,gdbjHandler);
						ewlbj_radio.enabled = true;
						ewlbj_radio.addEventListener(MouseEvent.CLICK,ewlbjHandler);
						ewbbj_radio.enabled = true;
						ewbbj_radio.addEventListener(MouseEvent.CLICK,ewbbjHandler);
						jfbj_radio.enabled = true;
						jfbj_radio.removeEventListener(MouseEvent.CLICK,jfbjHandler);
						
						gdbjFirButton.gotoAndStop(2);
						gdbjFirButton.removeEventListener(MouseEvent.CLICK,gdbjFirHandler);
						gdbjSecButton.gotoAndStop(2);
						gdbjSecButton.removeEventListener(MouseEvent.CLICK,gdbjSecHandler);
						gdbjThiButton.gotoAndStop(2);
						gdbjThiButton.removeEventListener(MouseEvent.CLICK,gdbjThiHandler);
						gdbjFouButton.gotoAndStop(2);
						gdbjFouButton.removeEventListener(MouseEvent.CLICK,gdbjFouHandler);
						gdbjFifButton.gotoAndStop(2);
						gdbjFifButton.removeEventListener(MouseEvent.CLICK,gdbjFifHandler);
						gdbjSixButton.gotoAndStop(2);
						gdbjSixButton.removeEventListener(MouseEvent.CLICK,gdbjSixHandler);
						gdbjSevButton.gotoAndStop(2);
						gdbjSevButton.removeEventListener(MouseEvent.CLICK,gdbjSevHandler);
						
						sdbjzs_input.editable = true;
						sdbjzs_input.addEventListener(KeyboardEvent.KEY_UP, sdbjzsInput);
						sdbjxs_input.editable = true;
						sdbjxs_input.addEventListener(KeyboardEvent.KEY_UP, sdbjxsInput);
						bjszButton.gotoAndStop(1);
						bjszButton.addEventListener(MouseEvent.CLICK,bjszHandler);
						
						
						sdbjFirButton.gotoAndStop(1);
						sdbjFirButton.alpha = 0.5;
						sdbjFirButton.removeEventListener(MouseEvent.CLICK,sdbjFirHandler);
						sdbjSecButton.gotoAndStop(1);
						sdbjSecButton.alpha = 0.5;
						sdbjSecButton.removeEventListener(MouseEvent.CLICK,sdbjSecHandler);
						sdbjThiButton.gotoAndStop(1);
						sdbjThiButton.alpha = 0.5;
						sdbjThiButton.removeEventListener(MouseEvent.CLICK,sdbjThiHandler);
						sdbjFouButton.gotoAndStop(1);
						sdbjFouButton.alpha = 0.5;
						sdbjFouButton.removeEventListener(MouseEvent.CLICK,sdbjFouHandler);
						sdbjFifButton.gotoAndStop(1);
						sdbjFifButton.alpha = 0.5;
						sdbjFifButton.removeEventListener(MouseEvent.CLICK,sdbjFifHandler);
						sdbjSixButton.gotoAndStop(1);
						sdbjSixButton.alpha = 0.5;
						sdbjSixButton.removeEventListener(MouseEvent.CLICK,sdbjSixHandler);
					}
				}else {
					gdbj_radio.enabled = false;
					gdbj_radio.removeEventListener(MouseEvent.CLICK,gdbjHandler);
					ewlbj_radio.enabled = false;
					ewlbj_radio.removeEventListener(MouseEvent.CLICK,ewlbjHandler);
					ewbbj_radio.enabled = false;
					ewbbj_radio.removeEventListener(MouseEvent.CLICK,ewbbjHandler);
					jfbj_radio.enabled = false;
					jfbj_radio.removeEventListener(MouseEvent.CLICK,jfbjHandler);
				
					gdbjFirButton.gotoAndStop(2);
					gdbjFirButton.removeEventListener(MouseEvent.CLICK,gdbjFirHandler);
					gdbjSecButton.gotoAndStop(2);
					gdbjSecButton.removeEventListener(MouseEvent.CLICK,gdbjSecHandler);
					gdbjThiButton.gotoAndStop(2);
					gdbjThiButton.removeEventListener(MouseEvent.CLICK,gdbjThiHandler);
					gdbjFouButton.gotoAndStop(2);
					gdbjFouButton.removeEventListener(MouseEvent.CLICK,gdbjFouHandler);
					gdbjFifButton.gotoAndStop(2);
					gdbjFifButton.removeEventListener(MouseEvent.CLICK,gdbjFifHandler);
					gdbjSixButton.gotoAndStop(2);
					gdbjSixButton.removeEventListener(MouseEvent.CLICK,gdbjSixHandler);
					gdbjSevButton.gotoAndStop(2);
					gdbjSevButton.removeEventListener(MouseEvent.CLICK,gdbjSevHandler);
				
					sdbjzs_input.editable = false;
					sdbjzs_input.removeEventListener(KeyboardEvent.KEY_UP, sdbjzsInput);
					sdbjxs_input.editable = false;
					sdbjxs_input.removeEventListener(KeyboardEvent.KEY_UP, sdbjxsInput);
					bjszButton.gotoAndStop(2);
					bjszButton.removeEventListener(MouseEvent.CLICK,bjszHandler);
					
					sdbjFirButton.gotoAndStop(1);
					sdbjFirButton.alpha = 0.5;
					sdbjFirButton.removeEventListener(MouseEvent.CLICK,sdbjFirHandler);
					sdbjSecButton.gotoAndStop(1);
					sdbjSecButton.alpha = 0.5;
					sdbjSecButton.removeEventListener(MouseEvent.CLICK,sdbjSecHandler);
					sdbjThiButton.gotoAndStop(1);
					sdbjThiButton.alpha = 0.5;
					sdbjThiButton.removeEventListener(MouseEvent.CLICK,sdbjThiHandler);
					sdbjFouButton.gotoAndStop(1);
					sdbjFouButton.alpha = 0.5;
					sdbjFouButton.removeEventListener(MouseEvent.CLICK,sdbjFouHandler);
					sdbjFifButton.gotoAndStop(1);
					sdbjFifButton.alpha = 0.5;
					sdbjFifButton.removeEventListener(MouseEvent.CLICK,sdbjFifHandler);
					sdbjSixButton.gotoAndStop(1);
					sdbjSixButton.alpha = 0.5;
					sdbjSixButton.removeEventListener(MouseEvent.CLICK,sdbjSixHandler);
				}
				
				if( item_status == "0" ){
					sdcjzs_input.editable = true;
					sdcjzs_input.addEventListener(KeyboardEvent.KEY_UP, sdcjzsInput);
					sdcjxs_input.editable = true;
					sdcjxs_input.addEventListener(KeyboardEvent.KEY_UP, sdcjxsInput);	
					sqpjButton.gotoAndStop(1);
					sqpjButton.addEventListener(MouseEvent.CLICK,sqpjHandler);
					addChild(sqpjButton);
				}else{
					sdcjzs_input.editable = false;
					sdcjzs_input.removeEventListener(KeyboardEvent.KEY_UP, sdcjzsInput);
					sdcjxs_input.editable = false;
					sdcjxs_input.removeEventListener(KeyboardEvent.KEY_UP, sdcjxsInput);
					sqpjButton.gotoAndStop(2);
					sqpjButton.removeEventListener(MouseEvent.CLICK,sqpjHandler);
					addChild(sqpjButton);
				}
				
				sdcjButton.gotoAndStop(2);
				sdcjButton.removeEventListener(MouseEvent.CLICK,sdcjHandler);
			
				djssd_input.editable = true;
				djssd_input.addEventListener(KeyboardEvent.KEY_UP, djssdInput);
				djssdButton.gotoAndStop(1);
				djssdButton.addEventListener(MouseEvent.CLICK,djssdHandler);
				
				recordPriceButton.gotoAndStop(1);
				recordPriceButton.label_text.text = "出价记录";
				recordPriceButton.removeEventListener(MouseEvent.CLICK,recordPriceHandler);
				priceDataGrid.visible = false;
				recordDealButton.gotoAndStop(1);
				recordDealButton.label_text.text = "成交记录";
				recordDealButton.removeEventListener(MouseEvent.CLICK,recordDealHandler);
				dealDataGrid.visible = false;
				
				selectItem_input.editable = true;
				selectItem_input.addEventListener(KeyboardEvent.KEY_UP, selectItemInput);
				selectItemButton.gotoAndStop(1);
				selectItemButton.addEventListener(MouseEvent.CLICK,selectItemHandler);
				/*prevPageButton.gotoAndStop(1);
				prevPageButton.addEventListener(MouseEvent.CLICK,prevPageHandler);
				nextPageButton.gotoAndStop(1);
				nextPageButton.addEventListener(MouseEvent.CLICK,nextPageHandler);*/
			}else if(auction_status == "1"){
				if( (item_status == "2" || item_status == "3" || item_status == "4") 
							&& (price_user_type == "1" || price_user_type == "2") && pause_flag != "1" ){
					returnPriceButton.gotoAndStop(1);
					returnPriceButton.addEventListener(MouseEvent.CLICK,returnPriceHandler);
				}else{
					returnPriceButton.gotoAndStop(2);
					returnPriceButton.removeEventListener(MouseEvent.CLICK,returnPriceHandler);
				}
				if( (item_status != "1" && item_status != "2" && item_status != "3") || pause_flag == "1"){
					countTimeButton.gotoAndStop(2);
					countTimeButton.removeEventListener(MouseEvent.CLICK,countTimeHandler);
				}else {
					countTimeButton.gotoAndStop(1);
					countTimeButton.addEventListener(MouseEvent.CLICK,countTimeHandler);
				}
				if(item_status == "0" && item_price != "0" && pause_flag != "1"){
					startButton.gotoAndStop(1);
					startButton.addEventListener(MouseEvent.CLICK,startHandler);
				}else{
					startButton.gotoAndStop(2);
					startButton.removeEventListener(MouseEvent.CLICK,startHandler);
				}
				if( (item_status == "2" || item_status == "3" || item_status == "4") 
						&& price_user_type != "null" && pause_flag != "1" ){
					dealButton.gotoAndStop(1);
					dealButton.addEventListener(MouseEvent.CLICK,dealHandler);
				}else{
					dealButton.gotoAndStop(2);
					dealButton.removeEventListener(MouseEvent.CLICK,dealHandler);
				}
				if( (item_status == "1" || item_status == "4") && price_user_type == "null" 
						&& pause_flag != "1" ){
					bidFailureButton.gotoAndStop(1);
					bidFailureButton.addEventListener(MouseEvent.CLICK,bidFailureHandler);
				}else{
					bidFailureButton.gotoAndStop(2);
					bidFailureButton.removeEventListener(MouseEvent.CLICK,bidFailureHandler);
				}
				if( (item_status == "0" || item_status == "5" 
				   	|| item_status == "6" || item_status == "7" 
					|| item_status == "8") && pause_flag != "1" ){
					nextItemButton.gotoAndStop(1);
					nextItemButton.addEventListener(MouseEvent.CLICK,nextItemHandler);
				}else{
					nextItemButton.gotoAndStop(2);
					nextItemButton.removeEventListener(MouseEvent.CLICK,nextItemHandler);
				}
				if( (item_status == "5" || item_status == "6" 
				   	|| item_status == "7" || item_status == "8") && pause_flag != "1" ){
					redoItemButton.gotoAndStop(1);
					redoItemButton.addEventListener(MouseEvent.CLICK,redoItemHandler);
				}else{
					redoItemButton.gotoAndStop(2);
					redoItemButton.removeEventListener(MouseEvent.CLICK,redoItemHandler);
				}
				if( pause_flag == "1"){
					continueItemButton.gotoAndStop(1);
					continueItemButton.addEventListener(MouseEvent.CLICK,continueItemHandler);
					addChild(continueItemButton);
					pauseItemButton.gotoAndStop(2);
					pauseItemButton.removeEventListener(MouseEvent.CLICK,pauseItemHandler);
				}else{
					continueItemButton.gotoAndStop(2);
					continueItemButton.removeEventListener(MouseEvent.CLICK,continueItemHandler);
					pauseItemButton.gotoAndStop(1);
					pauseItemButton.addEventListener(MouseEvent.CLICK,pauseItemHandler);
					addChild(pauseItemButton);
				}
				if( (item_status == "1" || item_status == "2" 
				   	|| item_status == "3" || item_status == "4") && pause_flag != "1" ){
					currentPriceButton.gotoAndStop(1);
					currentPriceButton.addEventListener(MouseEvent.CLICK,currentPriceHandler);
					currentPriceFirButton.gotoAndStop(1);
					currentPriceFirButton.addEventListener(MouseEvent.CLICK,currentPriceFirHandler);
					currentPriceSecButton.gotoAndStop(1);
					currentPriceSecButton.addEventListener(MouseEvent.CLICK,currentPriceSecHandler);
					currentPriceThiButton.gotoAndStop(1);
					currentPriceThiButton.addEventListener(MouseEvent.CLICK,currentPriceThiHandler);
					currentPriceFouButton.gotoAndStop(1);
					currentPriceFouButton.addEventListener(MouseEvent.CLICK,currentPriceFouHandler);
				}else{
					currentPriceButton.gotoAndStop(2);
					currentPriceButton.removeEventListener(MouseEvent.CLICK,currentPriceHandler);
					currentPriceFirButton.gotoAndStop(2);
					currentPriceFirButton.removeEventListener(MouseEvent.CLICK,currentPriceFirHandler);
					currentPriceSecButton.gotoAndStop(2);
					currentPriceSecButton.removeEventListener(MouseEvent.CLICK,currentPriceSecHandler);
					currentPriceThiButton.gotoAndStop(2);
					currentPriceThiButton.removeEventListener(MouseEvent.CLICK,currentPriceThiHandler);
					currentPriceFouButton.gotoAndStop(2);
					currentPriceFouButton.removeEventListener(MouseEvent.CLICK,currentPriceFouHandler);
				}
				if( item_status == "0"  && pause_flag != "1" ){
					bidDelayButton.gotoAndStop(1);
					bidDelayButton.addEventListener(MouseEvent.CLICK,bidDelayHandler);
					bidCancelButton.gotoAndStop(1);
					bidCancelButton.addEventListener(MouseEvent.CLICK,bidCancelHandler);
				}else {
					bidDelayButton.gotoAndStop(2);
					bidDelayButton.removeEventListener(MouseEvent.CLICK,bidDelayHandler);
					bidCancelButton.gotoAndStop(2);
					bidCancelButton.removeEventListener(MouseEvent.CLICK,bidCancelHandler);
				}
				if( item_status == "5"  && pause_flag != "1" ){
					dealCancelButton.gotoAndStop(1);
					dealCancelButton.addEventListener(MouseEvent.CLICK,dealCancelHandler);
				}else{
					dealCancelButton.gotoAndStop(2);
					dealCancelButton.removeEventListener(MouseEvent.CLICK,dealCancelHandler);
				}
				auctionStartButton.gotoAndStop(2);
				auctionStartButton.removeEventListener(MouseEvent.CLICK,auctionStartHandler);
				
				if( item_status == "0" || item_status == "1" || item_status == "2"
					   || item_status == "3" || item_status == "4" ){
					if(item_price_range_type =="1"){
						sdcjzs_input.text = "";
						sdcjxs_input.text = "";
						gdbj_radio.selected = true;
						gdbj_radio.enabled = true;
						gdbj_radio.removeEventListener(MouseEvent.CLICK,gdbjHandler);
						ewlbj_radio.enabled = true;
						ewlbj_radio.addEventListener(MouseEvent.CLICK,ewlbjHandler);
						ewbbj_radio.enabled = true;
						ewbbj_radio.addEventListener(MouseEvent.CLICK,ewbbjHandler);
						jfbj_radio.enabled = true;
						jfbj_radio.addEventListener(MouseEvent.CLICK,jfbjHandler);
						
						gdbjFirButton.gotoAndStop(1);
						gdbjFirButton.addEventListener(MouseEvent.CLICK,gdbjFirHandler);
						gdbjSecButton.gotoAndStop(1);
						gdbjSecButton.addEventListener(MouseEvent.CLICK,gdbjSecHandler);
						gdbjThiButton.gotoAndStop(1);
						gdbjThiButton.addEventListener(MouseEvent.CLICK,gdbjThiHandler);
						gdbjFouButton.gotoAndStop(1);
						gdbjFouButton.addEventListener(MouseEvent.CLICK,gdbjFouHandler);
						gdbjFifButton.gotoAndStop(1);
						gdbjFifButton.addEventListener(MouseEvent.CLICK,gdbjFifHandler);
						gdbjSixButton.gotoAndStop(1);
						gdbjSixButton.addEventListener(MouseEvent.CLICK,gdbjSixHandler);
						gdbjSevButton.gotoAndStop(1);
						gdbjSevButton.addEventListener(MouseEvent.CLICK,gdbjSevHandler);
						
						sdbjzs_input.editable = true;
						sdbjzs_input.addEventListener(KeyboardEvent.KEY_UP, sdbjzsInput);
						sdbjxs_input.editable = true;
						sdbjxs_input.addEventListener(KeyboardEvent.KEY_UP, sdbjxsInput);
						bjszButton.gotoAndStop(1);
						bjszButton.addEventListener(MouseEvent.CLICK,bjszHandler);
						
						sdbjFirButton.gotoAndStop(1);
						sdbjFirButton.alpha = 0.5;
						sdbjFirButton.removeEventListener(MouseEvent.CLICK,sdbjFirHandler);
						sdbjSecButton.gotoAndStop(1);
						sdbjSecButton.alpha = 0.5;
						sdbjSecButton.removeEventListener(MouseEvent.CLICK,sdbjSecHandler);
						sdbjThiButton.gotoAndStop(1);
						sdbjThiButton.alpha = 0.5;
						sdbjThiButton.removeEventListener(MouseEvent.CLICK,sdbjThiHandler);
						sdbjFouButton.gotoAndStop(1);
						sdbjFouButton.alpha = 0.5;
						sdbjFouButton.removeEventListener(MouseEvent.CLICK,sdbjFouHandler);
						sdbjFifButton.gotoAndStop(1);
						sdbjFifButton.alpha = 0.5;
						sdbjFifButton.removeEventListener(MouseEvent.CLICK,sdbjFifHandler);
						sdbjSixButton.gotoAndStop(1);
						sdbjSixButton.alpha = 0.5;
						sdbjSixButton.removeEventListener(MouseEvent.CLICK,sdbjSixHandler);
					}else if(item_price_range_type == "2"){
						sdcjzs_input.text = "";
						sdcjxs_input.text = "";
						ewlbj_radio.selected = true;
						gdbj_radio.enabled = true;
						gdbj_radio.addEventListener(MouseEvent.CLICK,gdbjHandler);
						ewlbj_radio.enabled = true;
						ewlbj_radio.removeEventListener(MouseEvent.CLICK,ewlbjHandler);
						ewbbj_radio.enabled = true;
						ewbbj_radio.addEventListener(MouseEvent.CLICK,ewbbjHandler);
						jfbj_radio.enabled = true;
						jfbj_radio.addEventListener(MouseEvent.CLICK,jfbjHandler);
						
						gdbjFirButton.gotoAndStop(2);
						gdbjFirButton.removeEventListener(MouseEvent.CLICK,gdbjFirHandler);
						gdbjSecButton.gotoAndStop(2);
						gdbjSecButton.removeEventListener(MouseEvent.CLICK,gdbjSecHandler);
						gdbjThiButton.gotoAndStop(2);
						gdbjThiButton.removeEventListener(MouseEvent.CLICK,gdbjThiHandler);
						gdbjFouButton.gotoAndStop(2);
						gdbjFouButton.removeEventListener(MouseEvent.CLICK,gdbjFouHandler);
						gdbjFifButton.gotoAndStop(2);
						gdbjFifButton.removeEventListener(MouseEvent.CLICK,gdbjFifHandler);
						gdbjSixButton.gotoAndStop(2);
						gdbjSixButton.removeEventListener(MouseEvent.CLICK,gdbjSixHandler);
						gdbjSevButton.gotoAndStop(2);
						gdbjSevButton.removeEventListener(MouseEvent.CLICK,gdbjSevHandler);
						
						sdbjzs_input.editable = false;
						sdbjzs_input.removeEventListener(KeyboardEvent.KEY_UP, sdbjzsInput);
						sdbjxs_input.editable = false;
						sdbjxs_input.removeEventListener(KeyboardEvent.KEY_UP, sdbjxsInput);
						bjszButton.gotoAndStop(2);
						bjszButton.removeEventListener(MouseEvent.CLICK,bjszHandler);
						
						sdbjFirButton.gotoAndStop(1);
						sdbjFirButton.addEventListener(MouseEvent.CLICK,sdbjFirHandler);
						sdbjSecButton.gotoAndStop(1);
						sdbjSecButton.addEventListener(MouseEvent.CLICK,sdbjSecHandler);
						sdbjThiButton.gotoAndStop(1);
						sdbjThiButton.addEventListener(MouseEvent.CLICK,sdbjThiHandler);
						sdbjFouButton.gotoAndStop(1);
						sdbjFouButton.addEventListener(MouseEvent.CLICK,sdbjFouHandler);
						sdbjFifButton.gotoAndStop(1);
						sdbjFifButton.addEventListener(MouseEvent.CLICK,sdbjFifHandler);
						sdbjSixButton.gotoAndStop(1);
						sdbjSixButton.addEventListener(MouseEvent.CLICK,sdbjSixHandler);
						if(item_price_range_mode == "1"){
							sdbjFirButton.gotoAndStop(2);
							sdbjFirButton.alpha = 1;
						}else if(item_price_range_mode == "2"){
							sdbjSecButton.gotoAndStop(2);
							sdbjSecButton.alpha = 1;
						}else if(item_price_range_mode == "3"){
							sdbjThiButton.gotoAndStop(2);
							sdbjThiButton.alpha = 1;
						}else if(item_price_range_mode == "4"){
							sdbjFouButton.gotoAndStop(2);
							sdbjFouButton.alpha = 1;
						}else if(item_price_range_mode == "5"){
							sdbjFifButton.gotoAndStop(2);
							sdbjFifButton.alpha = 1;
						}else if(item_price_range_mode == "6"){
							sdbjSixButton.gotoAndStop(2);
							sdbjSixButton.alpha = 1;
						}
					}else if(item_price_range_type == "3"){
						sdcjzs_input.text = "";
						sdcjxs_input.text = "";
						ewbbj_radio.selected = true;
						gdbj_radio.enabled = true;
						gdbj_radio.addEventListener(MouseEvent.CLICK,gdbjHandler);
						ewlbj_radio.enabled = true;
						ewlbj_radio.addEventListener(MouseEvent.CLICK,ewlbjHandler);
						ewbbj_radio.enabled = true;
						ewbbj_radio.removeEventListener(MouseEvent.CLICK,ewbbjHandler);
						jfbj_radio.enabled = true;
						jfbj_radio.addEventListener(MouseEvent.CLICK,jfbjHandler);
						
						gdbjFirButton.gotoAndStop(2);
						gdbjFirButton.removeEventListener(MouseEvent.CLICK,gdbjFirHandler);
						gdbjSecButton.gotoAndStop(2);
						gdbjSecButton.removeEventListener(MouseEvent.CLICK,gdbjSecHandler);
						gdbjThiButton.gotoAndStop(2);
						gdbjThiButton.removeEventListener(MouseEvent.CLICK,gdbjThiHandler);
						gdbjFouButton.gotoAndStop(2);
						gdbjFouButton.removeEventListener(MouseEvent.CLICK,gdbjFouHandler);
						gdbjFifButton.gotoAndStop(2);
						gdbjFifButton.removeEventListener(MouseEvent.CLICK,gdbjFifHandler);
						gdbjSixButton.gotoAndStop(2);
						gdbjSixButton.removeEventListener(MouseEvent.CLICK,gdbjSixHandler);
						gdbjSevButton.gotoAndStop(2);
						gdbjSevButton.removeEventListener(MouseEvent.CLICK,gdbjSevHandler);
						
						sdbjzs_input.editable = false;
						sdbjzs_input.removeEventListener(KeyboardEvent.KEY_UP, sdbjzsInput);
						sdbjxs_input.editable = false;
						sdbjxs_input.removeEventListener(KeyboardEvent.KEY_UP, sdbjxsInput);
						bjszButton.gotoAndStop(2);
						bjszButton.removeEventListener(MouseEvent.CLICK,bjszHandler);
						
						sdbjFirButton.gotoAndStop(1);
						sdbjFirButton.addEventListener(MouseEvent.CLICK,sdbjFirHandler);
						sdbjSecButton.gotoAndStop(1);
						sdbjSecButton.addEventListener(MouseEvent.CLICK,sdbjSecHandler);
						sdbjThiButton.gotoAndStop(1);
						sdbjThiButton.addEventListener(MouseEvent.CLICK,sdbjThiHandler);
						sdbjFouButton.gotoAndStop(1);
						sdbjFouButton.addEventListener(MouseEvent.CLICK,sdbjFouHandler);
						sdbjFifButton.gotoAndStop(1);
						sdbjFifButton.addEventListener(MouseEvent.CLICK,sdbjFifHandler);
						sdbjSixButton.gotoAndStop(1);
						sdbjSixButton.addEventListener(MouseEvent.CLICK,sdbjSixHandler);
						if(item_price_range_mode == "1"){
							sdbjFirButton.gotoAndStop(2);
							sdbjFirButton.alpha = 1;
						}else if(item_price_range_mode == "2"){
							sdbjSecButton.gotoAndStop(2);
							sdbjSecButton.alpha = 1;
						}else if(item_price_range_mode == "3"){
							sdbjThiButton.gotoAndStop(2);
							sdbjThiButton.alpha = 1;
						}else if(item_price_range_mode == "4"){
							sdbjFouButton.gotoAndStop(2);
							sdbjFouButton.alpha = 1;
						}else if(item_price_range_mode == "5"){
							sdbjFifButton.gotoAndStop(2);
							sdbjFifButton.alpha = 1;
						}else if(item_price_range_mode == "6"){
							sdbjSixButton.gotoAndStop(2);
							sdbjSixButton.alpha = 1;
						}
					}else if(item_price_range_type == "4"){
						jfbj_radio.selected = true;
						gdbj_radio.enabled = true;
						gdbj_radio.addEventListener(MouseEvent.CLICK,gdbjHandler);
						ewlbj_radio.enabled = true;
						ewlbj_radio.addEventListener(MouseEvent.CLICK,ewlbjHandler);
						ewbbj_radio.enabled = true;
						ewbbj_radio.addEventListener(MouseEvent.CLICK,ewbbjHandler);
						jfbj_radio.enabled = true;
						jfbj_radio.removeEventListener(MouseEvent.CLICK,jfbjHandler);
						
						gdbjFirButton.gotoAndStop(2);
						gdbjFirButton.removeEventListener(MouseEvent.CLICK,gdbjFirHandler);
						gdbjSecButton.gotoAndStop(2);
						gdbjSecButton.removeEventListener(MouseEvent.CLICK,gdbjSecHandler);
						gdbjThiButton.gotoAndStop(2);
						gdbjThiButton.removeEventListener(MouseEvent.CLICK,gdbjThiHandler);
						gdbjFouButton.gotoAndStop(2);
						gdbjFouButton.removeEventListener(MouseEvent.CLICK,gdbjFouHandler);
						gdbjFifButton.gotoAndStop(2);
						gdbjFifButton.removeEventListener(MouseEvent.CLICK,gdbjFifHandler);
						gdbjSixButton.gotoAndStop(2);
						gdbjSixButton.removeEventListener(MouseEvent.CLICK,gdbjSixHandler);
						gdbjSevButton.gotoAndStop(2);
						gdbjSevButton.removeEventListener(MouseEvent.CLICK,gdbjSevHandler);
						
						sdbjzs_input.editable = true;
						sdbjzs_input.addEventListener(KeyboardEvent.KEY_UP, sdbjzsInput);
						sdbjxs_input.editable = true;
						sdbjxs_input.addEventListener(KeyboardEvent.KEY_UP, sdbjxsInput);
						bjszButton.gotoAndStop(1);
						bjszButton.addEventListener(MouseEvent.CLICK,bjszHandler);
						
						sdbjFirButton.gotoAndStop(1);
						sdbjFirButton.alpha = 0.5;
						sdbjFirButton.removeEventListener(MouseEvent.CLICK,sdbjFirHandler);
						sdbjSecButton.gotoAndStop(1);
						sdbjSecButton.alpha = 0.5;
						sdbjSecButton.removeEventListener(MouseEvent.CLICK,sdbjSecHandler);
						sdbjThiButton.gotoAndStop(1);
						sdbjThiButton.alpha = 0.5;
						sdbjThiButton.removeEventListener(MouseEvent.CLICK,sdbjThiHandler);
						sdbjFouButton.gotoAndStop(1);
						sdbjFouButton.alpha = 0.5;
						sdbjFouButton.removeEventListener(MouseEvent.CLICK,sdbjFouHandler);
						sdbjFifButton.gotoAndStop(1);
						sdbjFifButton.alpha = 0.5;
						sdbjFifButton.removeEventListener(MouseEvent.CLICK,sdbjFifHandler);
						sdbjSixButton.gotoAndStop(1);
						sdbjSixButton.alpha = 0.5;
						sdbjSixButton.removeEventListener(MouseEvent.CLICK,sdbjSixHandler);
					}
				}else {
					gdbj_radio.enabled = false;
					gdbj_radio.removeEventListener(MouseEvent.CLICK,gdbjHandler);
					ewlbj_radio.enabled = false;
					ewlbj_radio.removeEventListener(MouseEvent.CLICK,ewlbjHandler);
					ewbbj_radio.enabled = false;
					ewbbj_radio.removeEventListener(MouseEvent.CLICK,ewbbjHandler);
					jfbj_radio.enabled = false;
					jfbj_radio.removeEventListener(MouseEvent.CLICK,jfbjHandler);
				
					gdbjFirButton.gotoAndStop(2);
					gdbjFirButton.removeEventListener(MouseEvent.CLICK,gdbjFirHandler);
					gdbjSecButton.gotoAndStop(2);
					gdbjSecButton.removeEventListener(MouseEvent.CLICK,gdbjSecHandler);
					gdbjThiButton.gotoAndStop(2);
					gdbjThiButton.removeEventListener(MouseEvent.CLICK,gdbjThiHandler);
					gdbjFouButton.gotoAndStop(2);
					gdbjFouButton.removeEventListener(MouseEvent.CLICK,gdbjFouHandler);
					gdbjFifButton.gotoAndStop(2);
					gdbjFifButton.removeEventListener(MouseEvent.CLICK,gdbjFifHandler);
					gdbjSixButton.gotoAndStop(2);
					gdbjSixButton.removeEventListener(MouseEvent.CLICK,gdbjSixHandler);
					gdbjSevButton.gotoAndStop(2);
					gdbjSevButton.removeEventListener(MouseEvent.CLICK,gdbjSevHandler);
				
					sdbjzs_input.editable = false;
					sdbjzs_input.removeEventListener(KeyboardEvent.KEY_UP, sdbjzsInput);
					sdbjxs_input.editable = false;
					sdbjxs_input.removeEventListener(KeyboardEvent.KEY_UP, sdbjxsInput);
					bjszButton.gotoAndStop(2);
					bjszButton.removeEventListener(MouseEvent.CLICK,bjszHandler);
					
					sdbjFirButton.gotoAndStop(1);
					sdbjFirButton.alpha = 0.5;
					sdbjFirButton.removeEventListener(MouseEvent.CLICK,sdbjFirHandler);
					sdbjSecButton.gotoAndStop(1);
					sdbjSecButton.alpha = 0.5;
					sdbjSecButton.removeEventListener(MouseEvent.CLICK,sdbjSecHandler);
					sdbjThiButton.gotoAndStop(1);
					sdbjThiButton.alpha = 0.5;
					sdbjThiButton.removeEventListener(MouseEvent.CLICK,sdbjThiHandler);
					sdbjFouButton.gotoAndStop(1);
					sdbjFouButton.alpha = 0.5;
					sdbjFouButton.removeEventListener(MouseEvent.CLICK,sdbjFouHandler);
					sdbjFifButton.gotoAndStop(1);
					sdbjFifButton.alpha = 0.5;
					sdbjFifButton.removeEventListener(MouseEvent.CLICK,sdbjFifHandler);
					sdbjSixButton.gotoAndStop(1);
					sdbjSixButton.alpha = 0.5;
					sdbjSixButton.removeEventListener(MouseEvent.CLICK,sdbjSixHandler);
				}
				
				if( (item_status == "0" || item_status == "1" || item_status == "2" 
					 	|| item_status == "3" || item_status == "4") && pause_flag != "1" ){
					sdcjzs_input.editable = true;
					sdcjzs_input.addEventListener(KeyboardEvent.KEY_UP, sdcjzsInput);
					sdcjxs_input.editable = true;
					sdcjxs_input.addEventListener(KeyboardEvent.KEY_UP, sdcjxsInput);
					if(item_price_range_type !="4" && item_status != "0"){
						sdcjxs_input.editable = false;
						sdcjxs_input.removeEventListener(KeyboardEvent.KEY_UP, sdcjxsInput);
					}
				}else{
					sdcjzs_input.editable = false;
					sdcjzs_input.removeEventListener(KeyboardEvent.KEY_UP, sdcjzsInput);
					sdcjxs_input.editable = false;
					sdcjxs_input.removeEventListener(KeyboardEvent.KEY_UP, sdcjxsInput);
				}
				if( (item_status == "1" || item_status == "2" 
					 	|| item_status == "3" || item_status == "4") && pause_flag != "1" ){
					sdcjButton.gotoAndStop(1);
					sdcjButton.addEventListener(MouseEvent.CLICK,sdcjHandler);
					addChild(sdcjButton);
				}else{
					sdcjButton.gotoAndStop(2);
					sdcjButton.removeEventListener(MouseEvent.CLICK,sdcjHandler);
				}
				if( item_status == "0" && pause_flag != "1" ){
					sqpjButton.gotoAndStop(1);
					sqpjButton.addEventListener(MouseEvent.CLICK,sqpjHandler);
					addChild(sqpjButton);
				}else{
					sqpjButton.gotoAndStop(2);
					sqpjButton.removeEventListener(MouseEvent.CLICK,sqpjHandler);
					if(contains(sdcjButton)){
					}else{
						addChild(sqpjButton);
					}
				}
				
				djssd_input.editable = true;
				djssd_input.addEventListener(KeyboardEvent.KEY_UP, djssdInput);
				djssdButton.gotoAndStop(1);
				djssdButton.addEventListener(MouseEvent.CLICK,djssdHandler);
				
				recordPriceButton.gotoAndStop(1); 
				recordPriceButton.label_text.text = "出价记录";
				recordPriceButton.removeEventListener(MouseEvent.CLICK,recordPriceHandler);
				priceDataGrid.visible = true;
				recordDealButton.gotoAndStop(2);
				recordDealButton.label_text.text = "成交记录";
				recordDealButton.addEventListener(MouseEvent.CLICK,recordDealHandler);
				dealDataGrid.visible = false;
				
				selectItem_input.editable = true;
				selectItem_input.addEventListener(KeyboardEvent.KEY_UP, selectItemInput);
				selectItemButton.gotoAndStop(1);
				selectItemButton.addEventListener(MouseEvent.CLICK,selectItemHandler);
				/*prevPageButton.gotoAndStop(1);
				prevPageButton.addEventListener(MouseEvent.CLICK,prevPageHandler);
				nextPageButton.gotoAndStop(1);
				nextPageButton.addEventListener(MouseEvent.CLICK,nextPageHandler);*/
			}else if(auction_status == "2"){
				returnPriceButton.gotoAndStop(2);
				returnPriceButton.removeEventListener(MouseEvent.CLICK,returnPriceHandler);
				countTimeButton.gotoAndStop(2);
				countTimeButton.removeEventListener(MouseEvent.CLICK,countTimeHandler);
				startButton.gotoAndStop(2);
				startButton.removeEventListener(MouseEvent.CLICK,startHandler);
				dealButton.gotoAndStop(2);
				dealButton.removeEventListener(MouseEvent.CLICK,dealHandler);
				bidFailureButton.gotoAndStop(2);
				bidFailureButton.removeEventListener(MouseEvent.CLICK,bidFailureHandler);
				nextItemButton.gotoAndStop(2);
				nextItemButton.removeEventListener(MouseEvent.CLICK,nextItemHandler);
				redoItemButton.gotoAndStop(2);
				redoItemButton.removeEventListener(MouseEvent.CLICK,redoItemHandler);
				continueItemButton.gotoAndStop(2);
				continueItemButton.removeEventListener(MouseEvent.CLICK,continueItemHandler);
				pauseItemButton.gotoAndStop(2);
				pauseItemButton.removeEventListener(MouseEvent.CLICK,pauseItemHandler);
				addChild(pauseItemButton);
				
				currentPriceButton.gotoAndStop(2);
				currentPriceButton.removeEventListener(MouseEvent.CLICK,currentPriceHandler);
				currentPriceFirButton.gotoAndStop(2);
				currentPriceFirButton.removeEventListener(MouseEvent.CLICK,currentPriceFirHandler);
				currentPriceSecButton.gotoAndStop(2);
				currentPriceSecButton.removeEventListener(MouseEvent.CLICK,currentPriceSecHandler);
				currentPriceThiButton.gotoAndStop(2);
				currentPriceThiButton.removeEventListener(MouseEvent.CLICK,currentPriceThiHandler);
				currentPriceFouButton.gotoAndStop(2);
				currentPriceFouButton.removeEventListener(MouseEvent.CLICK,currentPriceFouHandler);
				
				bidDelayButton.gotoAndStop(2);
				bidDelayButton.removeEventListener(MouseEvent.CLICK,bidDelayHandler);
				bidCancelButton.gotoAndStop(2);
				bidCancelButton.removeEventListener(MouseEvent.CLICK,bidCancelHandler);
				dealCancelButton.gotoAndStop(2);
				dealCancelButton.removeEventListener(MouseEvent.CLICK,dealCancelHandler);
				auctionStartButton.gotoAndStop(2);
				auctionStartButton.removeEventListener(MouseEvent.CLICK,auctionStartHandler);
				
				gdbj_radio.enabled = false;
				gdbj_radio.removeEventListener(MouseEvent.CLICK,gdbjHandler);
				ewlbj_radio.enabled = false;
				ewlbj_radio.removeEventListener(MouseEvent.CLICK,ewlbjHandler);
				ewbbj_radio.enabled = false;
				ewbbj_radio.removeEventListener(MouseEvent.CLICK,ewbbjHandler);
				jfbj_radio.enabled = false;
				jfbj_radio.removeEventListener(MouseEvent.CLICK,jfbjHandler);
				
				gdbjFirButton.gotoAndStop(2);
				gdbjFirButton.removeEventListener(MouseEvent.CLICK,gdbjFirHandler);
				gdbjSecButton.gotoAndStop(2);
				gdbjSecButton.removeEventListener(MouseEvent.CLICK,gdbjSecHandler);
				gdbjThiButton.gotoAndStop(2);
				gdbjThiButton.removeEventListener(MouseEvent.CLICK,gdbjThiHandler);
				gdbjFouButton.gotoAndStop(2);
				gdbjFouButton.removeEventListener(MouseEvent.CLICK,gdbjFouHandler);
				gdbjFifButton.gotoAndStop(2);
				gdbjFifButton.removeEventListener(MouseEvent.CLICK,gdbjFifHandler);
				gdbjSixButton.gotoAndStop(2);
				gdbjSixButton.removeEventListener(MouseEvent.CLICK,gdbjSixHandler);
				gdbjSevButton.gotoAndStop(2);
				gdbjSevButton.removeEventListener(MouseEvent.CLICK,gdbjSevHandler);
				
				sdbjzs_input.editable = false;
				sdbjzs_input.removeEventListener(KeyboardEvent.KEY_UP, sdbjzsInput);
				sdbjxs_input.editable = false;
				sdbjxs_input.removeEventListener(KeyboardEvent.KEY_UP, sdbjxsInput);
				bjszButton.gotoAndStop(2);
				bjszButton.removeEventListener(MouseEvent.CLICK,bjszHandler);
				
				sdbjFirButton.gotoAndStop(2);
				sdbjFirButton.removeEventListener(MouseEvent.CLICK,sdbjFirHandler);
				sdbjSecButton.gotoAndStop(2);
				sdbjSecButton.removeEventListener(MouseEvent.CLICK,sdbjSecHandler);
				sdbjThiButton.gotoAndStop(2);
				sdbjThiButton.removeEventListener(MouseEvent.CLICK,sdbjThiHandler);
				sdbjFouButton.gotoAndStop(2);
				sdbjFouButton.removeEventListener(MouseEvent.CLICK,sdbjFouHandler);
				sdbjFifButton.gotoAndStop(2);
				sdbjFifButton.removeEventListener(MouseEvent.CLICK,sdbjFifHandler);
				sdbjSixButton.gotoAndStop(2);
				sdbjSixButton.removeEventListener(MouseEvent.CLICK,sdbjSixHandler);
				
				sdcjzs_input.editable = false;
				sdcjzs_input.removeEventListener(KeyboardEvent.KEY_UP, sdcjzsInput);
				sdcjxs_input.editable = false;
				sdcjxs_input.removeEventListener(KeyboardEvent.KEY_UP, sdcjxsInput);
				
				sqpjButton.gotoAndStop(2);
				sqpjButton.removeEventListener(MouseEvent.CLICK,sqpjHandler);
				sdcjButton.gotoAndStop(2);
				sdcjButton.removeEventListener(MouseEvent.CLICK,sdcjHandler);
				addChild(sdcjButton);
				
				djssd_input.editable = false;
				djssd_input.removeEventListener(KeyboardEvent.KEY_UP, djssdInput);
				djssdButton.gotoAndStop(2);
				djssdButton.removeEventListener(MouseEvent.CLICK,djssdHandler);
				
				recordPriceButton.gotoAndStop(1); 
				recordPriceButton.label_text.text = "出价记录";
				recordPriceButton.removeEventListener(MouseEvent.CLICK,recordPriceHandler);
				priceDataGrid.visible = false;
				recordDealButton.gotoAndStop(1);
				recordDealButton.label_text.text = "成交记录";
				recordDealButton.removeEventListener(MouseEvent.CLICK,recordDealHandler);
				dealDataGrid.visible = false;
				
				selectItem_input.editable = false;
				selectItem_input.removeEventListener(KeyboardEvent.KEY_UP, selectItemInput);
				selectItemButton.gotoAndStop(2);
				selectItemButton.removeEventListener(MouseEvent.CLICK,selectItemHandler);
				/*prevPageButton.gotoAndStop(2);
				prevPageButton.removeEventListener(MouseEvent.CLICK,prevPageHandler);
				nextPageButton.gotoAndStop(2);
				nextPageButton.removeEventListener(MouseEvent.CLICK,nextPageHandler);*/
			}
			
			djssd_input.text = "" + count_time_flag;
			
			
		}
		
		private function returnPriceHandler(e:Event):void{
			sendMessage("08", (item_id + "&"));
			returnPriceButton.gotoAndStop(2);  
			returnPriceButton.removeEventListener(MouseEvent.CLICK,returnPriceHandler);
		}
		private function countTimeHandler(e:Event):void{
			sendMessage("09", (item_id + "&"));
			countTimeButton.gotoAndStop(2);
			countTimeButton.removeEventListener(MouseEvent.CLICK,countTimeHandler);
		}
		public function countdown(e:TimerEvent):void{
			count_down_text.visible = true;
			count_down_text.text = "" + count_down_time;
			count_down_time--;
			if(count_down_time == -1){
				itemStatus.text = "网络关闭";
				count_down_text.visible = false;
				countTimeCancelButton.gotoAndStop(2);
				countTimeCancelButton.removeEventListener(MouseEvent.CLICK,countTimeCancelHandler)
			}
		}
		private function countTimeCancelHandler(e:Event):void{
			sendMessage("10", (item_id + "&"));
			countTimeCancelButton.gotoAndStop(2);
			countTimeCancelButton.removeEventListener(MouseEvent.CLICK,countTimeCancelHandler)
		}
		private function startHandler(e:Event):void{
			sendMessage("01", (item_id + "&"));
			startButton.gotoAndStop(2);  
			startButton.removeEventListener(MouseEvent.CLICK,startHandler);
		}
		private function dealHandler(e:Event):void{
			if(price_user_type == "1"){
				sendMessage("04", (item_id + "&"));
				
				dealButton.gotoAndStop(2);  
				dealButton.removeEventListener(MouseEvent.CLICK,dealHandler);
				dealAlertBox = new DealAlertBox();
				dealAlertBox.addEventListener("okEvent",okDealResultHandler);
	       		dealAlertBox.addEventListener("closeEvent",closeDealResultHandler);
				addChild(dealAlertBox);
				stage.focus = dealAlertBox.bidNum_input;
			}else if(price_user_type == "2"){
				sendMessage("04", (item_id + "&"));
				
				dealButton.gotoAndStop(2);  
				dealButton.removeEventListener(MouseEvent.CLICK,dealHandler);
			}
		}
		function okDealResultHandler(evt:Event):void {	
			sendMessage("04", (item_id + "&" + dealAlertBox.bidNum_input.text +"&"));
			cleanMessageInput(evt);
		}
		function closeDealResultHandler(evt:Event):void {	
			sendMessage("88", (item_id + "&"));
			nextItemButton.gotoAndStop(2);  
			nextItemButton.removeEventListener(MouseEvent.CLICK,nextItemHandler);
			redoItemButton.gotoAndStop(2);  
			redoItemButton.removeEventListener(MouseEvent.CLICK,redoItemHandler);
	      	cleanMessageInput(evt);
	    }
		function cleanMessageInput(evt:Event):void{
	      evt.currentTarget.removeEventListener("okEvent",okDealResultHandler);
	      evt.currentTarget.removeEventListener("closeEvent",closeDealResultHandler);	
	      removeChild(evt.currentTarget as DisplayObject);
	    }
		
		private function bidFailureHandler(e:Event):void{
			sendMessage("05", (item_id + "&"));
			bidFailureButton.gotoAndStop(2);  
			bidFailureButton.removeEventListener(MouseEvent.CLICK,bidFailureHandler);
		}
		private function nextItemHandler(e:Event):void{
			if(nextItemButton.label_text.text == "结束拍卖会"){  
				nextItemButton.gotoAndStop(2);  
				nextItemButton.removeEventListener(MouseEvent.CLICK,dealHandler);
				auctionCloseAlertBox = new AuctionCloseAlertBox();
				auctionCloseAlertBox.addEventListener("okEvent",okAuctionCloseHandler);
	       		auctionCloseAlertBox.addEventListener("closeEvent",closeAuctionCloseHandler);
				auctionCloseAlertBox.addEventListener("cancelEvent",cancelAuctionCloseHandler);
				addChild(auctionCloseAlertBox);
			}else{
				sendMessage("07", (item_id + "&"));
				nextItemButton.gotoAndStop(2);  
				nextItemButton.removeEventListener(MouseEvent.CLICK,nextItemHandler);
			}
		}
		function okAuctionCloseHandler(evt:Event):void {	
			sendMessage("07", (item_id + "&"));
			nextItemButton.gotoAndStop(2);  
			nextItemButton.removeEventListener(MouseEvent.CLICK,nextItemHandler);
			cleanAuctionClose(evt);
		}
		function closeAuctionCloseHandler(evt:Event):void {	
			nextItemButton.gotoAndStop(1);  
			nextItemButton.addEventListener(MouseEvent.CLICK,nextItemHandler);
			cleanAuctionClose(evt);
	    }
		function cancelAuctionCloseHandler(evt:Event):void {	
			nextItemButton.gotoAndStop(1);  
			nextItemButton.addEventListener(MouseEvent.CLICK,nextItemHandler);
			cleanAuctionClose(evt);
	    }
		function cleanAuctionClose(evt:Event):void{
	      	evt.currentTarget.removeEventListener("okEvent",okAuctionCloseHandler);
	      	evt.currentTarget.removeEventListener("closeEvent",closeAuctionCloseHandler);	
		  	evt.currentTarget.removeEventListener("cancelEvent",cancelAuctionCloseHandler);	
	      	removeChild(evt.currentTarget as DisplayObject);
	    }
		
		private function redoItemHandler(e:Event):void{
			sendMessage("06", (item_id + "&"));
			redoItemButton.gotoAndStop(2);  
			redoItemButton.removeEventListener(MouseEvent.CLICK,redoItemHandler);
		}
		private function pauseItemHandler(e:Event):void{
			sendMessage("02", (item_id + "&"));
			pauseItemButton.gotoAndStop(2);  
			pauseItemButton.removeEventListener(MouseEvent.CLICK,pauseItemHandler);
		}
		private function continueItemHandler(e:Event):void{
			sendMessage("03", (item_id + "&"));
			continueItemButton.gotoAndStop(2);  
			continueItemButton.removeEventListener(MouseEvent.CLICK,continueItemHandler);
		}
		
		private function currentPriceHandler(e:Event):void{
			var price_val = currentPriceButton.label_text.text;
			if(item_status == "1"){
				if( new Number(price_val) >= new Number(level_fir) ){
					sendMessage("31", (item_id + "&" + price_val + "&"));
					currentPriceButton.gotoAndStop(2);  
					currentPriceButton.removeEventListener(MouseEvent.CLICK,currentPriceHandler);
				}
			}else if(item_status == "2"){
				if( new Number(price_val) > new Number(level_fir) ){
					sendMessage("31", (item_id + "&" + price_val + "&"));
					currentPriceButton.gotoAndStop(2);  
					currentPriceButton.removeEventListener(MouseEvent.CLICK,currentPriceHandler);
				}
			}else if(item_status == "3"){
				if( new Number(price_val) >= new Number(level_fir) ){
					sendMessage("31", (item_id + "&" + price_val + "&"));
					currentPriceButton.gotoAndStop(2);  
					currentPriceButton.removeEventListener(MouseEvent.CLICK,currentPriceHandler);
				}
			}else if(item_status == "4"){
				if(new Number(price_val) > new Number(level_fir)){
					sendMessage("31", (item_id + "&" + price_val + "&"));
					currentPriceButton.gotoAndStop(2);  
					currentPriceButton.removeEventListener(MouseEvent.CLICK,currentPriceHandler);
				}else if(new Number(price_val) == new Number(level_fir)){
					if(price_user_type != "1"){
						sendMessage("31", (item_id + "&" + price_val + "&"));
						currentPriceButton.gotoAndStop(2);  
						currentPriceButton.removeEventListener(MouseEvent.CLICK,currentPriceHandler);
					}
				}
			}
		}
		private function currentPriceFirHandler(e:Event):void{
			var price_val = currentPriceFirButton.label_text.text;
			sendMessage("31", (item_id + "&" + price_val + "&"));
			currentPriceFirButton.gotoAndStop(2);  
			currentPriceFirButton.removeEventListener(MouseEvent.CLICK,currentPriceFirHandler);
		}
		private function currentPriceSecHandler(e:Event):void{
			var price_val = currentPriceSecButton.label_text.text;
			sendMessage("31", (item_id + "&" + price_val + "&"));
			currentPriceSecButton.gotoAndStop(2);  
			currentPriceSecButton.removeEventListener(MouseEvent.CLICK,currentPriceSecHandler);
		}
		private function currentPriceThiHandler(e:Event):void{
			var price_val = currentPriceThiButton.label_text.text;
			sendMessage("31", (item_id + "&" + price_val + "&"));
			currentPriceThiButton.gotoAndStop(2);  
			currentPriceThiButton.removeEventListener(MouseEvent.CLICK,currentPriceThiHandler);
		}
		private function currentPriceFouHandler(e:Event):void{
			var price_val = currentPriceFouButton.label_text.text;
			sendMessage("31", (item_id + "&" + price_val + "&"));
			currentPriceFouButton.gotoAndStop(2);  
			currentPriceFouButton.removeEventListener(MouseEvent.CLICK,currentPriceFouHandler);
		}
		
		private function bidDelayHandler(e:Event):void{
			sendMessage("16", (item_id + "&"));
			bidDelayButton.gotoAndStop(2);  
			bidDelayButton.removeEventListener(MouseEvent.CLICK,bidDelayHandler);
		}
		private function bidCancelHandler(e:Event):void{
			sendMessage("15", (item_id + "&"));
			bidCancelButton.gotoAndStop(2);  
			bidCancelButton.removeEventListener(MouseEvent.CLICK,bidCancelHandler);
		}
		private function dealCancelHandler(e:Event):void{
			sendMessage("88", (item_id + "&"));
			dealCancelButton.gotoAndStop(2);  
			dealCancelButton.removeEventListener(MouseEvent.CLICK,dealCancelHandler);
		}
		private function auctionStartHandler(e:Event):void{
			sendMessage("89", "");
			auctionStartButton.gotoAndStop(2);  
			auctionStartButton.removeEventListener(MouseEvent.CLICK,auctionStartHandler);
		}
		
		private function gdbjHandler(e:Event):void{
			if(item_price_range_type != "1"){
				gdbj_radio.removeEventListener(MouseEvent.CLICK,gdbjHandler);
				sendMessage("11", (item_id + "&" + "1&"));
			}
		}
		private function ewlbjHandler(e:Event):void{
			if(item_price_range_type != "2"){
				ewlbj_radio.removeEventListener(MouseEvent.CLICK,ewlbjHandler);
				sendMessage("11", (item_id + "&" + "2&"));
			}
		}
		private function ewbbjHandler(e:Event):void{
			if(item_price_range_type != "3"){
				ewbbj_radio.removeEventListener(MouseEvent.CLICK,ewbbjHandler);
				sendMessage("11", (item_id + "&" + "3&"));
			}
		}
		private function jfbjHandler(e:Event):void{
			if(item_price_range_type != "4"){
				jfbj_radio.removeEventListener(MouseEvent.CLICK,jfbjHandler);
				sendMessage("11", (item_id + "&" + "4&"));
			}
		}
		
		private function gdbjFirHandler(e:Event):void{
			if(item_price_range != "100"){
				gdbjFirButton.removeEventListener(MouseEvent.CLICK,gdbjFirHandler);
				sendMessage("12", (item_id + "&" + "100&"));
			}
		}
		private function gdbjSecHandler(e:Event):void{
			if(item_price_range != "200"){
				gdbjSecButton.removeEventListener(MouseEvent.CLICK,gdbjSecHandler);
				sendMessage("12", (item_id + "&" + "200&"));
			}  
			
		}
		private function gdbjThiHandler(e:Event):void{
			if(item_price_range != "500"){
				gdbjThiButton.removeEventListener(MouseEvent.CLICK,gdbjThiHandler);
				sendMessage("12", (item_id + "&" + "500&"));
			}   
		}
		private function gdbjFouHandler(e:Event):void{
			if(item_price_range != "1000"){
				gdbjFouButton.removeEventListener(MouseEvent.CLICK,gdbjFouHandler);
				sendMessage("12", (item_id + "&" + "1000&"));
			} 
		}
		private function gdbjFifHandler(e:Event):void{
			if(item_price_range != "2000"){
				gdbjFifButton.removeEventListener(MouseEvent.CLICK,gdbjFifHandler);
				sendMessage("12", (item_id + "&" + "2000&"));
			} 
		}
		private function gdbjSixHandler(e:Event):void{
			if(item_price_range != "5000"){
				gdbjSixButton.removeEventListener(MouseEvent.CLICK,gdbjSixHandler);
				sendMessage("12", (item_id + "&" + "5000&"));
			} 
		}
		private function gdbjSevHandler(e:Event):void{
			if(item_price_range != "10000"){
				gdbjSevButton.removeEventListener(MouseEvent.CLICK,gdbjSevHandler);
				sendMessage("12", (item_id + "&" + "10000&"));
			} 
		}
		
		private function sdbjzsInput(event:KeyboardEvent):void {
			var range_value:String = event.target.text;
			var reg:RegExp = new RegExp("^[1-9][0-9]{0,7}$","g");
			if(reg.test(range_value) == true){
				sdbjzs_input.text = range_value;
			}else{
				sdbjzs_input.text = "";
			}
		}
		private function sdbjxsInput(event:KeyboardEvent):void {
			var range_value:String = event.target.text;
			var reg:RegExp = new RegExp("^[0-9][0-9]{0,1}$","g");
			if(reg.test(range_value) == true){
				sdbjxs_input.text = range_value;
			}else{
				sdbjxs_input.text = "";
			}
		}
		private function bjszHandler(e:Event):void{
			if(item_price_range_type == "1"){
				if(sdbjzs_input.text == ""){
					return;
				}
				if(sdbjzs_input.text != "" && sdbjzs_input.text != item_price_range){
					sendMessage("12", (item_id + "&" +  sdbjzs_input.text + "&"));
				}
			}else if(item_price_range_type == "4"){
				if(sdbjzs_input.text == "" || sdbjxs_input.text == ""){
					return;
				}
				var jf_val:String;
				if(new uint(sdbjxs_input.text) == 0){
					jf_val = "00";
				}else{
					jf_val = sdbjxs_input.text;
				}
				if((sdbjzs_input.text + jf_val) != item_price_range && new uint((sdbjzs_input.text + jf_val)) != 0){
					sendMessage("12", (item_id + "&" +  (sdbjzs_input.text + "." + sdbjxs_input.text) + "&"));
				}
			} 
		}
		private function setRangeEditArea():void{
			if(item_price_range_type == "1"){
				sdbjzs_input.text = item_price_range;
				sdbjxs_input.text = "";
				sdbjxs_input.editable = false;
			}else if(item_price_range_type == "2"){
				sdbjzs_input.text = "";
				sdbjxs_input.text = "";
			}else if(item_price_range_type == "3"){
				sdbjzs_input.text = "";
				sdbjxs_input.text = "";
			}else if(item_price_range_type == "4"){
				if(item_price_range.indexOf(".") != -1){
					sdbjzs_input.text = item_price_range.substr(0,(item_price_range.indexOf(".")));
					sdbjxs_input.text = item_price_range.substr((item_price_range.indexOf(".")+1),item_price_range.length);
				}else{
					sdbjzs_input.text = item_price_range;
					sdbjxs_input.text = "00";
					sdbjxs_input.editable = true;
				}
			}
		}
		private function sdbjFirHandler(e:Event):void{
			sendMessage("13", (item_id + "&" + "1&"));
		}
		private function sdbjSecHandler(e:Event):void{
			sendMessage("13", (item_id + "&" + "2&"));
		}
		private function sdbjThiHandler(e:Event):void{
			sendMessage("13", (item_id + "&" + "3&"));
		}
		private function sdbjFouHandler(e:Event):void{
			sendMessage("13", (item_id + "&" + "4&"));
		}
		private function sdbjFifHandler(e:Event):void{
			sendMessage("13", (item_id + "&" + "5&"));
		}
		private function sdbjSixHandler(e:Event):void{
			sendMessage("13", (item_id + "&" + "6&"));
		}
		
		private function sdcjzsInput(event:KeyboardEvent):void {
			var reg_alivePrice:RegExp = new RegExp("^[1-9][0-9]{0,10}$","g");
			if(reg_alivePrice.test(sdcjzs_input.text) == true){
			}else{
				sdcjzs_input.text = "";
			}
		}
		private function sdcjxsInput(event:KeyboardEvent):void {
			var reg_alivePrice:RegExp = new RegExp("^[0-9][0-9]{0,1}$","g");
			if(reg_alivePrice.test(sdcjxs_input.text) == true){
			}else{
				sdcjxs_input.text = "";
			}
		}
		private function sqpjHandler(e:Event):void{
			var i_p_value:String;
			
			if(sdcjxs_input.length == 0){
				i_p_value = sdcjzs_input.text;
			}
			if(sdcjxs_input.length == 1){
				i_p_value = sdcjzs_input.text + ".0" + sdcjxs_input.text;
			}
			if(sdcjxs_input.length == 2){
				i_p_value = sdcjzs_input.text + "." + sdcjxs_input.text;
			}
			
			if(sdcjzs_input.length == 0 && sdcjxs_input.length == 0){
			}else{
				if(i_p_value != item_price){
					sendMessage("21", (item_id + "&" + i_p_value + "&"));
					sdcjzs_input.text = "";
					sdcjxs_input.text = "";
					sqpjButton.gotoAndStop(2);  
			sqpjButton.removeEventListener(MouseEvent.CLICK,sqpjHandler);
				}
			}
		}
		private function sdcjHandler(e:Event):void{
			var i_p_value:String;
			
			if(sdcjxs_input.length == 0){
				i_p_value = sdcjzs_input.text;
			}
			if(sdcjxs_input.length == 1){
				i_p_value = sdcjzs_input.text + ".0" + sdcjxs_input.text;
			}
			if(sdcjxs_input.length == 2){
				i_p_value = sdcjzs_input.text + "." + sdcjxs_input.text;
			}
			
			if(sdcjzs_input.length == 0 && sdcjxs_input.length == 0){
			}else{
				if(new Number(i_p_value) >= new Number(level_fir)){
					sendMessage("31", (item_id + "&" + i_p_value + "&"));
					sdcjzs_input.text = "";
					sdcjxs_input.text = "";
					sdcjButton.gotoAndStop(2);  
					sdcjButton.removeEventListener(MouseEvent.CLICK,sdcjHandler);
				}
			}
			
		}
		
		private function djssdInput(event:KeyboardEvent):void {
			var count_value:String = event.target.text;
			var reg:RegExp = new RegExp("^[1-9][0-9]{0,4}$","g");
			if(reg.test(count_value) == true){
				djssd_input.text = count_value;
			}else{
				djssd_input.text = "" + count_time_flag;
			}
		}
		private function djssdHandler(e:Event):void{
			if(djssd_input.text != "0" && djssd_input.text != ("" + count_time_flag)){
				sendMessage("14", (item_id + "&" + djssd_input.text + "&"));
				djssdButton.gotoAndStop(2);
				djssdButton.removeEventListener(MouseEvent.CLICK,djssdHandler);
			}  
		}
		
		private function recordPriceHandler(e:Event):void{
			recordPriceButton.gotoAndStop(1); 
			recordPriceButton.label_text.text = "出价记录";
			recordPriceButton.removeEventListener(MouseEvent.CLICK,recordPriceHandler);
			priceDataGrid.visible = true;
			recordDealButton.gotoAndStop(2);
			recordDealButton.label_text.text = "成交记录";
			recordDealButton.addEventListener(MouseEvent.CLICK,recordDealHandler);
			dealDataGrid.visible = false;
		}
		private function recordDealHandler(e:Event):void{
			recordDealButton.gotoAndStop(1);  
			recordDealButton.label_text.text = "成交记录";
			recordDealButton.removeEventListener(MouseEvent.CLICK,recordDealHandler);
			priceDataGrid.visible = false;
			recordPriceButton.gotoAndStop(2); 
			recordPriceButton.label_text.text = "出价记录";
			recordPriceButton.addEventListener(MouseEvent.CLICK,recordPriceHandler);
			dealDataGrid.visible = true;
		}
		
		private function selectItemInput(event:KeyboardEvent):void {
			var reg_aliveItem:RegExp = new RegExp("^[1-9][0-9]{0,3}$","g");
			if(reg_aliveItem.test(selectItem_input.text) == true){
			}else{
				selectItem_input.text = "" + item_index;
			}
		}
		private function selectItemHandler(e:Event):void{
			if( new uint(selectItem_input.text) > 0 
					&& new uint(selectItem_input.text) <= new uint(item_count) 
					&& new uint(selectItem_input.text) != new uint(item_index) 
					&& pause_flag != "1" && (item_status != "1" && item_status != "2" 
					&& item_status != "3" && item_status != "4") ){
				sendMessage("41", (item_id + "&" + selectItem_input.text + "&"));
				selectItemButton.gotoAndStop(2);  
				selectItemButton.removeEventListener(MouseEvent.CLICK,selectItemHandler);
			}else{
				selectItem_input.text = "" + item_index;
			}
			
		}
		private function prevPageHandler(e:Event):void{
			if((new uint(item_page_index_flag) - 3) > 0){
				sendMessage("22", (item_id + "&" + (new uint(item_page_index_flag) - 3) + "&"));
				prevPageButton.gotoAndStop(2);  
				prevPageButton.removeEventListener(MouseEvent.CLICK,prevPageHandler);
			}
		}
		private function nextPageHandler(e:Event):void{
			if((new uint(item_page_index_flag) + 3) <= (new uint(item_count))){
				sendMessage("22", (item_id + "&" + (new uint(item_page_index_flag) + 3) + "&"));
				nextPageButton.gotoAndStop(2);  
				nextPageButton.removeEventListener(MouseEvent.CLICK,nextPageHandler);
			}
		}
		
		private function setPriceButtonValue():void{
			currentPriceButton.label_text.text = level_fir;
			currentPriceFirButton.label_text.text = level_sec;
			currentPriceSecButton.label_text.text = level_thi;
			currentPriceThiButton.label_text.text = level_fou;
			currentPriceFouButton.label_text.text = level_fif;
		}
		
		private function getDateStatus():String{
			var date:Date = new Date();
			var hours_val:String = "" + date.getHours();
			var minutes_val:String = "" + date.getMinutes();
			var seconds_val:String = "" + date.getSeconds();
			
			if(hours_val.length == 1){
				hours_val = "0" + hours_val;
			}
			if(minutes_val.length == 1){
				minutes_val = "0" + minutes_val;
			}
			if(seconds_val.length == 1){
				seconds_val = "0" + seconds_val;
			}
			return "[" + hours_val + ":" + minutes_val + ":" + seconds_val + "]";
		}
		private function getDateStatusRecorder():String{
			var date:Date = new Date();
			var hours_val:String = "" + date.getHours();
			var minutes_val:String = "" + date.getMinutes();
			var seconds_val:String = "" + date.getSeconds();
			
			if(hours_val.length == 1){
				hours_val = "0" + hours_val;
			}
			if(minutes_val.length == 1){
				minutes_val = "0" + minutes_val;
			}
			if(seconds_val.length == 1){
				seconds_val = "0" + seconds_val;
			}
			return "" + hours_val + ":" + minutes_val + ":" + seconds_val + "";
		}
		
		private function setAuctionStatusList(status_val:String):void{
			var operate_date:String = getDateStatus();  
			var status_content:String = status_val;
			
			if(status_counter < status_counter_max){
				aliveStatus.htmlText = "<span><font size='14' color='#333333' face='宋体'>" + operate_date + "" + status_content + "</font></span><br/>" + aliveStatus.htmlText;
				//aliveStatus.text = "" + operate_date + "" + status_content + "\n" + aliveStatus.text;
				status_counter++;
			}else{
				var text_temp = aliveStatus.htmlText;
				aliveStatus.htmlText = "<span><font size='14' color='#333333' face='宋体'>" + operate_date + "" + status_content + "</font></span><br/>" + text_temp.slice(0,text_temp.lastIndexOf("["));
				//aliveStatus.text = "" + operate_date + "" + status_content + "\n" + text_temp.slice(0,text_temp.lastIndexOf("["))
			}
		}
		
		private function setPriceDataList():void{
			var price_type:String = "";
			if(price_user_type == "1"){
				price_type = "现场";
			}else if(price_user_type == "2"){
				price_type = "网络";
			}
			if(priceDataProvider.length < status_counter_max){
				priceDataProvider.addItemAt({flag:"0", 时间:getDateStatusRecorder(), 用户:price_type, 出价:level_fir,拍品:item_index,拍牌:price_user_bid}, new uint(0));
			}else{
				priceDataProvider.removeItemAt(new uint(status_counter_max)-1);
				priceDataProvider.addItemAt({flag:"0", 时间:getDateStatusRecorder(), 用户:price_type, 出价:level_fir,拍品:item_index,拍牌:price_user_bid}, new uint(0));
			}
		}
		private function setDealDataList():void{  
			var price_type:String = "";
			if(price_user_type == "1"){
				price_type = "现场";
			}else if(price_user_type == "2"){
				price_type = "网络";
			}
			if(dealDataProvider.length < status_counter_max){
				dealDataProvider.addItemAt({flag:"0", 时间:getDateStatusRecorder(), 用户:price_type, 出价:level_fir,拍品:item_index,拍牌:price_user_bid}, new uint(0));
			}else{
				dealDataProvider.removeItemAt(new uint(status_counter_max)-1);
				dealDataProvider.addItemAt({flag:"0", 时间:getDateStatusRecorder(), 用户:price_type, 出价:level_fir,拍品:item_index,拍牌:price_user_bid}, new uint(0));
			}
		}
		
		private function setPicStatus():void{
			var current_item:uint = new uint(item_index)%3;
			var request:URLRequest;
			if(current_item == 1 && item_page_index_flag == item_index){
				if(item_status == "0"){
					/*request = new URLRequest("mbtn_06.png");
					itemStatusImgFir.load(request);*/
					itemStatusImgFir.source = imgLoader.getContent("fir_status_six");
				}else if(item_status == "1" || item_status == "2" || item_status == "3" || item_status == "4"){
					/*request = new URLRequest("mbtn_01.png");
					itemStatusImgFir.load(request);*/
					itemStatusImgFir.source = imgLoader.getContent("fir_status_fir");
				}else if(item_status == "5" ){
					/*request = new URLRequest("mbtn_04.png");
					itemStatusImgFir.load(request);*/
					itemStatusImgFir.source = imgLoader.getContent("fir_status_fou");
				}else if(item_status == "6" ){
					/*request = new URLRequest("mbtn_05.png");
					itemStatusImgFir.load(request);*/
					itemStatusImgFir.source = imgLoader.getContent("fir_status_fif");
				}else if(item_status == "7" || item_status == "8"){
					/*request = new URLRequest("mbtn_03.png");
					itemStatusImgFir.load(request);*/
					itemStatusImgFir.source = imgLoader.getContent("fir_status_thi");
				}
				if(pause_flag == "1"){
					/*request = new URLRequest("mbtn_02.png");
            		itemStatusImgFir.load(request);*/
					itemStatusImgFir.source = imgLoader.getContent("fir_status_sec");
				}
			}else if(current_item == 2 && item_page_index_flag == item_index){
				if(item_status == "0"){
					/*request = new URLRequest("mbtn_06.png");
					itemStatusImgSec.load(request);*/
					itemStatusImgSec.source = imgLoader.getContent("sec_status_six");
				}else if(item_status == "1" || item_status == "2" || item_status == "3" || item_status == "4"){
					/*request = new URLRequest("mbtn_01.png");
					itemStatusImgSec.load(request);*/
					itemStatusImgSec.source = imgLoader.getContent("sec_status_fir");
				}else if(item_status == "5" ){
					/*request = new URLRequest("mbtn_04.png");
					itemStatusImgSec.load(request);*/
					itemStatusImgSec.source = imgLoader.getContent("sec_status_fou");
				}else if(item_status == "6" ){
					/*request = new URLRequest("mbtn_05.png");
					itemStatusImgSec.load(request);*/
					itemStatusImgSec.source = imgLoader.getContent("sec_status_fif");
				}else if(item_status == "7" || item_status == "8"){
					/*request = new URLRequest("mbtn_03.png");
					itemStatusImgSec.load(request);*/
					itemStatusImgSec.source = imgLoader.getContent("sec_status_thi");
				}
				if(pause_flag == "1"){
					/*request = new URLRequest("mbtn_02.png");
            		itemStatusImgSec.load(request);*/
					itemStatusImgSec.source = imgLoader.getContent("sec_status_sec");
				}
			}else if(current_item == 0 && item_page_index_flag == item_index){
				if(item_status == "0"){
					/*request = new URLRequest("mbtn_06.png");
					itemStatusImgThi.load(request);*/
					itemStatusImgThi.source = imgLoader.getContent("thi_status_six");
				}else if(item_status == "1" || item_status == "2" || item_status == "3" || item_status == "4"){
					/*request = new URLRequest("mbtn_01.png");
					itemStatusImgThi.load(request);*/
					itemStatusImgThi.source = imgLoader.getContent("thi_status_fir");
				}else if(item_status == "5" ){
					/*request = new URLRequest("mbtn_04.png");
					itemStatusImgThi.load(request);*/
					itemStatusImgThi.source = imgLoader.getContent("thi_status_fou");
				}else if(item_status == "6" ){
					/*request = new URLRequest("mbtn_05.png");
					itemStatusImgThi.load(request);*/
					itemStatusImgThi.source = imgLoader.getContent("thi_status_fif");
				}else if(item_status == "7" || item_status == "8"){
					/*request = new URLRequest("mbtn_03.png");
					itemStatusImgThi.load(request);*/
					itemStatusImgThi.source = imgLoader.getContent("thi_status_thi");
				}
				if(pause_flag == "1"){
					/*request = new URLRequest("mbtn_02.png");
            		itemStatusImgThi.load(request);*/
					itemStatusImgThi.source = imgLoader.getContent("thi_status_sec");
				}
			}
			if((new uint(item_page_index_flag) - 3) > 0){
				prevPageButton.gotoAndStop(1);  
				prevPageButton.addEventListener(MouseEvent.CLICK,prevPageHandler);
			}else{
				prevPageButton.gotoAndStop(2);  
				prevPageButton.removeEventListener(MouseEvent.CLICK,prevPageHandler);
			}
			if((new uint(item_page_index_flag) + 3) <= (new uint(item_count))){
				nextPageButton.gotoAndStop(1);  
				nextPageButton.addEventListener(MouseEvent.CLICK,nextPageHandler);
			}else{
				nextPageButton.gotoAndStop(2);  
				nextPageButton.removeEventListener(MouseEvent.CLICK,nextPageHandler);
			}
			
		}
		private function setPicList():void{
			selectItem_input.text = item_index
			var current_item:uint = new uint(item_index)%3;
			if(item_status_fir != null && item_status_fir != ""){
				var index_fir:String = item_status_fir.substr(0,item_status_fir.indexOf(","));
				var status_fir:String = item_status_fir.substr(item_status_fir.indexOf(",")+1,item_status_fir.length);
				var pic_url_fir:String = xml_file.item.(id==index_fir).item_pic_url;
				var request:URLRequest = new URLRequest(pic_url_fir.substr(1,pic_url_fir.length));
            	itemListImgFir.load(request);
				itemListImgFir.addEventListener(IOErrorEvent.IO_ERROR, ioErrorListImgFirHandler);
				/*request = new URLRequest("nopic.jpg");
				itemListImgFir_nopic.load(request);*/
				itemListImgFir_nopic.source = imgLoader.getContent("no_pic_fir");
				itemListImgFir_nopic.visible = false;
				
				itemListIndexFir_text.text = xml_file.item.(id==index_fir).indexId;
				itemListNameFir_text.text = xml_file.item.(id==index_fir).itemName;
				if(status_fir == "0"){
					itemStatusImgFir.source = imgLoader.getContent("fir_status_six");
					/*request = new URLRequest("mbtn_06.png");
					itemStatusImgFir.load(request);*/
				}else if(status_fir == "1" || status_fir == "2" || status_fir == "3" || status_fir == "4"){
					/*request = new URLRequest("mbtn_01.png");
					itemStatusImgFir.load(request);*/
					itemStatusImgFir.source = imgLoader.getContent("fir_status_fir");
				}else if(status_fir == "5" ){
					/*request = new URLRequest("mbtn_04.png");
					itemStatusImgFir.load(request);*/
					itemStatusImgFir.source = imgLoader.getContent("fir_status_fou");
				}else if(status_fir == "6" ){
					/*request = new URLRequest("mbtn_05.png");
					itemStatusImgFir.load(request);*/
					itemStatusImgFir.source = imgLoader.getContent("fir_status_fif");
				}else if(status_fir == "7" || status_fir == "8"){
					/*request = new URLRequest("mbtn_03.png");
					itemStatusImgFir.load(request);*/
					itemStatusImgFir.source = imgLoader.getContent("fir_status_thi");
				}
			}
			if(item_status_sec != null && item_status_sec != ""){
				var index_sec:String = item_status_sec.substr(0,item_status_sec.indexOf(","));
				var status_sec:String = item_status_sec.substr(item_status_sec.indexOf(",")+1,item_status_sec.length);
				var pic_url_sec:String = xml_file.item.(id==index_sec).item_pic_url;
				request = new URLRequest(pic_url_sec.substr(1,pic_url_sec.length));
            	itemListImgSec.load(request);
				itemListImgSec.addEventListener(IOErrorEvent.IO_ERROR, ioErrorListImgSecHandler);
				itemListImgSec_nopic.source = imgLoader.getContent("no_pic_sec");
				itemListImgSec_nopic.visible = false;
				
				itemListIndexSec_text.text = xml_file.item.(id==index_sec).indexId;
				itemListNameSec_text.text = xml_file.item.(id==index_sec).itemName;
				if(status_sec == "0"){
					/*request = new URLRequest("mbtn_06.png");
					itemStatusImgSec.load(request);*/
					itemStatusImgSec.source = imgLoader.getContent("sec_status_six");
				}else if(status_sec == "1" || status_sec == "2" || status_sec == "3" || status_sec == "4"){
					/*request = new URLRequest("mbtn_01.png");
					itemStatusImgSec.load(request);*/
					itemStatusImgSec.source = imgLoader.getContent("sec_status_fir");
				}else if(status_sec == "5" ){
					/*request = new URLRequest("mbtn_04.png");
					itemStatusImgSec.load(request);*/
					itemStatusImgSec.source = imgLoader.getContent("sec_status_fou");
				}else if(status_sec == "6" ){
					/*request = new URLRequest("mbtn_05.png");
					itemStatusImgSec.load(request);*/
					itemStatusImgSec.source = imgLoader.getContent("sec_status_fif");
				}else if(status_sec == "7" || status_sec == "8"){
					/*request = new URLRequest("mbtn_06.png");
					itemStatusImgSec.load(request);*/
					itemStatusImgSec.source = imgLoader.getContent("sec_status_thi");
				}
				itemListImgSec.visible = true;
				itemStatusImgSec.visible = true;
			}else{
				itemListImgSec.visible = false;
				itemListImgSec_nopic.visible = false;
				itemListIndexSec_text.text = "";
				itemListNameSec_text.text = "";
				itemStatusImgSec.visible = false;
			}
			if(item_status_thi != null && item_status_thi != ""){
				var index_thi:String = item_status_thi.substr(0,item_status_thi.indexOf(","));
				var status_thi:String = item_status_thi.substr(item_status_thi.indexOf(",")+1,item_status_thi.length);
				var pic_url_thi:String = xml_file.item.(id==index_thi).item_pic_url;
				request = new URLRequest(pic_url_thi.substr(1,pic_url_thi.length));
            	itemListImgThi.load(request);
				itemListImgThi.addEventListener(IOErrorEvent.IO_ERROR, ioErrorListImgThiHandler);
				itemListImgThi_nopic.source = imgLoader.getContent("no_pic_thi");
				itemListImgThi_nopic.visible = false;
				
				itemListIndexThi_text.text = xml_file.item.(id==index_thi).indexId;
				itemListNameThi_text.text = xml_file.item.(id==index_thi).itemName;
				if(status_thi == "0"){
					/*request = new URLRequest("mbtn_06.png");
					itemStatusImgThi.load(request);*/
					itemStatusImgThi.source = imgLoader.getContent("thi_status_six");
				}else if(status_thi == "1" || status_thi == "2" || status_thi == "3" || status_thi == "4"){
					/*request = new URLRequest("mbtn_01.png");
					itemStatusImgThi.load(request);*/
					itemStatusImgThi.source = imgLoader.getContent("thi_status_fir");
				}else if(status_thi == "5" ){
					/*request = new URLRequest("mbtn_04.png");
					itemStatusImgThi.load(request);*/
					itemStatusImgThi.source = imgLoader.getContent("thi_status_fou");
				}else if(status_thi == "6" ){
					/*request = new URLRequest("mbtn_05.png");
					itemStatusImgThi.load(request);*/
					itemStatusImgThi.source = imgLoader.getContent("thi_status_fif");
				}else if(status_thi == "7" || status_thi == "8"){
					/*request = new URLRequest("mbtn_06.png");
					itemStatusImgThi.load(request);*/
					itemStatusImgThi.source = imgLoader.getContent("thi_status_thi");
				}
				itemListImgThi.visible = true;
				itemStatusImgThi.visible = true;
			}else{
				itemListImgThi.visible = false;
				itemListImgThi_nopic.visible = false;
				itemListIndexThi_text.text = "";
				itemListNameThi_text.text = "";
				itemStatusImgThi.visible = false;
			}
			
			if(current_item == 1 && item_page_index_flag == item_index){
				itemListIndexFir_text.border = true;
				itemListIndexFir_text.htmlText = "<font color='#FF0000'>" + itemListIndexFir_text.text + "</font>";
				itemListIndexSec_text.border = false;
				itemListIndexThi_text.border = false;
				if(pause_flag == "1"){
					/*request = new URLRequest("mbtn_02.png");
            		itemStatusImgFir.load(request);*/
					itemStatusImgFir.source = imgLoader.getContent("fir_status_sec");
				}
			}else if(current_item == 2 && item_page_index_flag == item_index){
				itemListIndexFir_text.border = false;
				itemListIndexSec_text.border = true;
				itemListIndexSec_text.htmlText = "<font color='#FF0000'>" + itemListIndexSec_text.text + "</font>";
				itemListIndexThi_text.border = false;
				if(pause_flag == "1"){
					/*request = new URLRequest("mbtn_02.png");
            		itemStatusImgSec.load(request);*/
					itemStatusImgSec.source = imgLoader.getContent("sec_status_sec");
				}
			}else if(current_item == 0 && item_page_index_flag == item_index){
				itemListIndexFir_text.border = false;
				itemListIndexSec_text.border = false;
				itemListIndexThi_text.border = true;
				itemListIndexThi_text.htmlText = "<font color='#FF0000'>" + itemListIndexThi_text.text + "</font>";
				if(pause_flag == "1"){
					/*request = new URLRequest("mbtn_02.png");
            		itemStatusImgThi.load(request);*/
					itemStatusImgThi.source = imgLoader.getContent("thi_status_sec");
				}
			}else{
				itemListIndexFir_text.border = false;
				itemListIndexSec_text.border = false;
				itemListIndexThi_text.border = false;
			}
			if((new uint(item_page_index_flag) - 3) > 0){
				prevPageButton.gotoAndStop(1);  
				prevPageButton.addEventListener(MouseEvent.CLICK,prevPageHandler);
			}else{
				prevPageButton.gotoAndStop(2);  
				prevPageButton.removeEventListener(MouseEvent.CLICK,prevPageHandler);
			}
			if((new uint(item_page_index_flag) + 3) <= (new uint(item_count))){
				nextPageButton.gotoAndStop(1);  
				nextPageButton.addEventListener(MouseEvent.CLICK,nextPageHandler);
			}else{
				nextPageButton.gotoAndStop(2);  
				nextPageButton.removeEventListener(MouseEvent.CLICK,nextPageHandler);
			}
			selectItemButton.gotoAndStop(1);  
			selectItemButton.addEventListener(MouseEvent.CLICK,selectItemHandler);
		}
		private function ioErrorListImgFirHandler(e:IOErrorEvent):void {
			itemListImgFir_nopic.visible = true;
		}
		private function ioErrorListImgSecHandler(e:IOErrorEvent):void {
			itemListImgSec_nopic.visible = true;
		}
		private function ioErrorListImgThiHandler(e:IOErrorEvent):void {
			itemListImgThi_nopic.visible = true;
		}
	}
}