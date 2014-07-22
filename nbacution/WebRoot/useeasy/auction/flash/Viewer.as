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
	
	public class Viewer extends MovieClip {
		
        private var socket:Socket;
		
		private var param:Object = root.loaderInfo.parameters;
		
		private var auction_port:String;
		private var auction_id:String;
		private var account_id:String;
		private var xml_num:String;
		private var auction_name:String;
		private var viewer_num:String;
		
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
		
		private var base_url:String = "http://172.16.171.80:8180";
		//private var base_url:String = "http://wangpai1.staa.com.cn/";
		//private var base_url:String = "http://172.16.171.77:8080/auction_n/";
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
		
		var connectCloseAlertBox:ConnectCloseAlertBox;
		
		private var videoPlayer:VideoPlayer;
		private var serverURL:String;
		private var videoURL:String;
		
		public function Viewer() {
			if(param["auction_port"] != null){
				auction_port = param["auction_port"];
			}else{
				auction_port = "6956";
			}
			setDefaultStatus();
			socket = new Socket();
			socket.connect("172.16.171.80",6956);
			//socket.connect("localhost",6958);
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
			
			auctionStatus.text = "-";
			aliveNum.text = "当前在线:-人";
			
			videoButton.removeEventListener(MouseEvent.CLICK, stratVideoHandler);
			
			count_down_text.visible = false;
			itemTitle.text = "-";
			item_image.source = "";
			itemName.text = "拍品名称:-"; 
			
			itemCommissionType.text = "佣金标准:-";
			itemUnit.text = "数量/单位:-";
			itemValuationMethod.text = "计价方式:-";
			itemMargin.text = "需保证金:-";
			
			
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
			
			itemInfoButton.gotoAndStop(2);
			itemInfoButton.label_text.htmlText = "拍品信息";
			itemDescriptionButton.gotoAndStop(2);
			itemDescriptionButton.label_text.htmlText = "备注";
			
			currentPriceFirButton.gotoAndStop(2);
			currentPriceFirButton.label_text.htmlText = "<b>0</b>";
			currentPriceSecButton.gotoAndStop(2);
			currentPriceSecButton.label_text.htmlText = "<b>0</b>";
			currentPriceThiButton.gotoAndStop(2);
			currentPriceThiButton.label_text.htmlText = "<b>0</b>";
			currentPriceFouButton.gotoAndStop(2);
			currentPriceFouButton.label_text.htmlText = "<b>0</b>";
			
			priceStatusAlive.gotoAndStop(2);
			priceStatusAlive.typeTitle.htmlText = "现场出价";
			priceStatusWeb.gotoAndStop(2);
			priceStatusWeb.typeTitle.htmlText = "网络出价";
			
			aliveStatusTitle.text = "现在状态";
			aliveStatus.htmlText = "<span><font size='14' color='#333333' face='宋体'></font></span>";
			aliveStatus.editable = false;
			
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
			
			
		}
		
		private function connectHandler(e:Event):void{
			trace("socket connected:  " + e);
			if(param["auction_id"] != null){
				auction_id = param["auction_id"];
			}else{
				auction_id = "1420";
			}
			if(param["account_id"] != null){
				account_id = param["account_id"];
			}else{
				account_id = "33";
			}
			if(param["xml_num"] != null){
				xml_num = param["xml_num"];
			}else{
				xml_num = "57pXC0G418hBGY2o3i6M";
			}
			if(param["auction_name"] != null){
				auction_name = param["auction_name"];
			}else{
				auction_name = "-";
			}
			if(param["viewer_num"] != null){
				viewer_num = param["viewer_num"];
			}else{
				viewer_num = "-";
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
			sendMessage("90", (auction_id + "&" + account_id + "&gv&" + viewer_num + "&"));
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
						barLabel.move(xmlProgressBar.x+115, xmlProgressBar.y + xmlProgressBar.height);
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
						setPriceButtonValue();
						setPicList();
						
					}else if(connect_status == "89"){
						auction_status = "1";
						setAuctionStatus();
						setDescriptionArea();
						setTitleArea();
						setControlButtonArea();
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
							setPriceButtonValue();
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
							}
							setTitleArea();
							setControlButtonArea();
							setPriceButtonValue();
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
							setPriceButtonValue();
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
									setPriceButtonValue();
									setPicStatus();
									
									setAuctionStatusList(item_index + "号拍品已成交");
								}
							}else{
								setTitleArea();
								setControlButtonArea();
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
							setPriceButtonValue();
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
							}
							setTitleArea();
							setControlButtonArea();
							setPriceButtonValue();
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
							price_user_id = line_array[6];
							
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
							setPriceButtonValue();
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
						setPriceButtonValue();
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
							}
							
							setTitleArea();
							setControlButtonArea();
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
							}
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
							setPriceButtonValue();
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
							setPriceButtonValue();
							setAuctionStatusList(item_index + "号拍品切换250,258模式幅度");
						}
					}else if(connect_status == "14"){
						item_id_flag = line_array[3];
						if(item_id_flag != item_id){
							sendMessage("87", (item_id + "&"));
						}else{
							count_time_flag = line_array[4];
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
							setPriceButtonValue();
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
							setPriceButtonValue();
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
							
							setTitleArea();
							setControlButtonArea();
							setPriceButtonValue();
							
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
							}
							
							setTitleArea();
							setControlButtonArea();
							setPriceButtonValue();
							setPriceDataList();
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
				auctionStatus.text = "拍卖会正在进行。";
			}else if( auction_status == "2" ){
				auctionStatus.text = "拍卖会已经结束。";
			}
		}
		
		private function setAliveNum(){
			aliveNum.text = "当前在线:" + user_number + "人";
		}
		
		private function setDescriptionArea(){
			//showMedia.addEventListener(MouseEvent.CLICK,fnCallJs);
			videoButton.addEventListener(MouseEvent.CLICK, stratVideoHandler);
			
			itemTitle.text = auction_name;
			userInfo.htmlText = "用户名:-" + "<br/>" + "拍牌号:-";
			marginInfo.htmlText = "已付保证金:-" + "<br/>" + "剩余保证金:-";
			authorityAndProxy.htmlText = "我的出价权:-<br/>我的代理价:-";
			
			var request:URLRequest = new URLRequest(item_pic_url.substr(1,item_pic_url.length));
            item_image.load(request);
			item_image.addEventListener(IOErrorEvent.IO_ERROR, ioErrorImgHandler);
			/*request = new URLRequest("nopic.jpg");
			item_image_nopic.load(request);*/
			item_image_nopic.source = imgLoader.getContent("no_pic_main");
			item_image_nopic.visible = false;
			
			itemName.text = "拍品名称:" + item_name; 
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
			
			itemDescription.htmlText = "<span><font size='14' color='#666666' face='宋体'>" + item_description + "</font></span>";
			
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
			cleanMessageInput(evt);
	    }
		private function cleanMessageInput(evt:Event):void{
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
					itemCurrentPrice.htmlText = "<b><font color='#00DDDD' size='76'>" + current_val_head + 
						"</font></b><b><font color='#00DDDD' size='60'>" + current_val_end + "</font></b>";
				}else{
					itemCurrentPrice.htmlText = "<b><font color='#00DDDD' size='76' face='Arial'>" + level_fir + "</font></b>"; 
				}
			}else if(price_user_type == "2"){
				priceStatusAlive.gotoAndStop(2);
				priceStatusAlive.typeTitle.htmlText = "现场出价";
				priceStatusWeb.gotoAndStop(1);
				priceStatusWeb.typeTitle.htmlText = "网络出价";
				if(current_val_integer.length > 4){
					current_val_head = current_val_integer.substr(0,current_val_integer.length-4);
					current_val_end = current_val_integer.substr(current_val_integer.length-4,current_val_integer.length) + current_val_dicemal;
					itemCurrentPrice.htmlText = "<b><font color='#FFF000' size='76'>" + current_val_head + 
						"</font></b><b><font color='#FFF000' size='60'>" + current_val_end + "</font></b>";
				}else{
					itemCurrentPrice.htmlText = "<b><font color='#FFF000' size='76' face='Arial'>" + level_fir + "</font></b>"; 
				}
			}else{
				priceStatusAlive.gotoAndStop(2);
				priceStatusAlive.typeTitle.htmlText = "现场出价";
				priceStatusWeb.gotoAndStop(2);
				priceStatusWeb.typeTitle.htmlText = "网络出价";
				if(current_val_integer.length > 4){
					current_val_head = current_val_integer.substr(0,current_val_integer.length-4);
					current_val_end = current_val_integer.substr(current_val_integer.length-4,current_val_integer.length) + current_val_dicemal;
					itemCurrentPrice.htmlText = "<b><font color='#FFFFFF' size='76'>" + current_val_head + 
						"</font></b><b><font color='#FFFFFF' size='60'>" + current_val_end + "</font></b>";
				}else{
					itemCurrentPrice.htmlText = "<b><font color='#FFFFFF' size='76' face='Arial'>" + level_fir + "</font></b>"; 
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
				itemStatus.text = "成交";
			}else if(item_status == "6"){
				itemStatus.text = "流标";
				itemCurrentPrice.htmlText = "<font color='#FFF000' size='50' face='黑体'>流标</font></b>"; 
			}else if(item_status == "7"){
				itemStatus.text = "撤拍";
				itemCurrentPrice.htmlText = "<font color='#FFF000' size='50' face='黑体'>撤拍</font></b>"; 
			}else if(item_status == "8"){
				itemStatus.text = "缓拍";
				itemCurrentPrice.htmlText = "<font color='#FFF000' size='50' face='黑体'>缓拍</font></b>"; 
			}
			
			if(pause_flag == "1"){
				itemStatus.text = "暂停";
			}
		}
		
		private function setControlButtonArea(){
			
			
			if(auction_status == "0"){
				
				itemInfoButton.gotoAndStop(1); 
				itemInfoButton.label_text.text = "拍品信息";
				itemInfoButton.removeEventListener(MouseEvent.CLICK,itemInfoHandler);
				itemDescription.visible = true;
				itemDescriptionButton.gotoAndStop(1);
				itemDescriptionButton.label_text.text = "备注";
				itemDescriptionButton.removeEventListener(MouseEvent.CLICK,itemDescriptionHandler);
				
				recordPriceButton.gotoAndStop(1);
				recordPriceButton.label_text.text = "出价记录";
				recordPriceButton.removeEventListener(MouseEvent.CLICK,recordPriceHandler);
				priceDataGrid.visible = false;
				recordDealButton.gotoAndStop(1);
				recordDealButton.label_text.text = "成交记录";
				recordDealButton.removeEventListener(MouseEvent.CLICK,recordDealHandler);
				dealDataGrid.visible = false;
				
			}else if(auction_status == "1"){
				itemInfoButton.gotoAndStop(1); 
				itemInfoButton.label_text.text = "拍品信息";
				itemInfoButton.removeEventListener(MouseEvent.CLICK,itemInfoHandler);
				itemDescription.visible = false;
				itemDescriptionButton.gotoAndStop(2);
				itemDescriptionButton.label_text.text = "备注";
				itemDescriptionButton.addEventListener(MouseEvent.CLICK,itemDescriptionHandler);
				
				recordPriceButton.gotoAndStop(1); 
				recordPriceButton.label_text.text = "出价记录";
				recordPriceButton.removeEventListener(MouseEvent.CLICK,recordPriceHandler);
				priceDataGrid.visible = true;
				recordDealButton.gotoAndStop(2);
				recordDealButton.label_text.text = "成交记录";
				recordDealButton.addEventListener(MouseEvent.CLICK,recordDealHandler);
				dealDataGrid.visible = false;
				
			}else if(auction_status == "2"){
				itemInfoButton.gotoAndStop(1); 
				itemInfoButton.label_text.text = "拍品信息";
				itemInfoButton.removeEventListener(MouseEvent.CLICK,itemInfoHandler);
				itemDescriptionButton.gotoAndStop(1);
				itemDescriptionButton.label_text.text = "备注";
				itemDescriptionButton.removeEventListener(MouseEvent.CLICK,itemDescriptionHandler);
				
				recordPriceButton.gotoAndStop(1); 
				recordPriceButton.label_text.text = "出价记录";
				recordPriceButton.removeEventListener(MouseEvent.CLICK,recordPriceHandler);
				priceDataGrid.visible = false;
				recordDealButton.gotoAndStop(1);
				recordDealButton.label_text.text = "成交记录";
				recordDealButton.removeEventListener(MouseEvent.CLICK,recordDealHandler);
				dealDataGrid.visible = false;
			}
			
		}
		
		private function itemInfoHandler(e:Event):void{
			itemInfoButton.gotoAndStop(1); 
			itemInfoButton.label_text.text = "拍品信息";
			itemInfoButton.removeEventListener(MouseEvent.CLICK,itemInfoHandler);
			itemDescription.visible = false;
			itemDescriptionButton.gotoAndStop(2);
			itemDescriptionButton.label_text.text = "备注";
			itemDescriptionButton.addEventListener(MouseEvent.CLICK,itemDescriptionHandler);
		}
		private function itemDescriptionHandler(e:Event):void{
			itemInfoButton.gotoAndStop(2); 
			itemInfoButton.label_text.text = "拍品信息";
			itemInfoButton.addEventListener(MouseEvent.CLICK,itemInfoHandler);
			itemDescription.visible = true;
			itemDescriptionButton.gotoAndStop(1);
			itemDescriptionButton.label_text.text = "备注";
			itemDescriptionButton.removeEventListener(MouseEvent.CLICK,itemDescriptionHandler);
		}
		
		public function countdown(e:TimerEvent):void{
			count_down_text.visible = true;
			count_down_text.text = "" + count_down_time;
			count_down_time--;
			if(count_down_time == -1){
				itemStatus.text = "网络关闭";
				count_down_text.visible = false;
			}
		}
		
		private function setPriceButtonValue():void{
			plus_fir_mvc.gotoAndStop(2);
			plus_sec_mvc.gotoAndStop(2);
			plus_thi_mvc.gotoAndStop(2);
			plus_fou_mvc.gotoAndStop(2);
			currentPriceFirLabel.textColor = 0x999999;
			currentPriceSecLabel.textColor = 0x999999;
			currentPriceThiLabel.textColor = 0x999999;
			currentPriceFouLabel.textColor = 0x999999;
			
			var fir_num = new Number(level_sec) - new Number(level_fir);
			var sec_num = new Number(level_thi) - new Number(level_fir);
			var thi_num = new Number(level_fou) - new Number(level_fir);
			var fou_num = new Number(level_fif) - new Number(level_fir);
			currentPriceFirLabel.text = "" + fir_num;
			if(currentPriceFirLabel.text.indexOf(".") != -1){
				currentPriceFirLabel.text = "" + fir_num.toFixed(2);
			}
			currentPriceSecLabel.text = "" + sec_num;
			if(currentPriceSecLabel.text.indexOf(".") != -1){
				currentPriceSecLabel.text = "" + sec_num.toFixed(2);
			}
			currentPriceThiLabel.text = "" + thi_num;
			if(currentPriceThiLabel.text.indexOf(".") != -1){
				currentPriceThiLabel.text = "" + thi_num.toFixed(2);
			}
			currentPriceFouLabel.text = "" + fou_num;
			if(currentPriceFouLabel.text.indexOf(".") != -1){
				currentPriceFouLabel.text = "" + fou_num.toFixed(2);
			}
			
			currentPriceButton.label_text.text = level_fir;
			currentPriceFirButton.label_text.text = level_sec;
			currentPriceSecButton.label_text.text = level_thi;
			currentPriceThiButton.label_text.text = level_fou;
			currentPriceFouButton.label_text.text = level_fif;
			if(item_status == "0"){
				itemCurrentPrice.htmlText = "0";
				currentPriceButton.label_text.text = "0";
				currentPriceFirButton.label_text.text = "0";
				currentPriceSecButton.label_text.text = "0";
				currentPriceThiButton.label_text.text = "0";
				currentPriceFouButton.label_text.text = "0";
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
				aliveStatus.htmlText = "<span><font size='14' color='#666666' face='宋体'>" + operate_date + "" + status_content + "</font></span><br/>" + aliveStatus.htmlText;
				//aliveStatus.text = "" + operate_date + "" + status_content + "\n" + aliveStatus.text;
				status_counter++;
			}else{
				var text_temp = aliveStatus.htmlText;
				aliveStatus.htmlText = "<span><font size='14' color='#666666' face='宋体'>" + operate_date + "" + status_content + "</font></span><br/>" + text_temp.slice(0,text_temp.lastIndexOf("["));
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
				if(price_user_id == account_id){
					priceDataProvider.addItemAt({flag:"0", 时间:getDateStatusRecorder(), 用户:price_type, 出价:level_fir,拍品:item_index,拍牌:price_user_bid}, new uint(0));
				}else{
					priceDataProvider.addItemAt({flag:"0", 时间:getDateStatusRecorder(), 用户:price_type, 出价:level_fir,拍品:item_index,拍牌:price_user_bid}, new uint(0));
				}
			}else{
				priceDataProvider.removeItemAt(new uint(status_counter_max)-1);
				if(price_user_id == account_id){
					priceDataProvider.addItemAt({flag:"0", 时间:getDateStatusRecorder(), 用户:price_type, 出价:level_fir,拍品:item_index,拍牌:price_user_bid}, new uint(0));
				}else{
					priceDataProvider.addItemAt({flag:"0", 时间:getDateStatusRecorder(), 用户:price_type, 出价:level_fir,拍品:item_index,拍牌:price_user_bid}, new uint(0));
				}
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
				if(price_user_id == account_id){
					dealDataProvider.addItemAt({flag:"0", 时间:getDateStatusRecorder(), 用户:price_type, 出价:level_fir,拍品:item_index,拍牌:price_user_bid}, new uint(0));
				}else{
					dealDataProvider.addItemAt({flag:"0", 时间:getDateStatusRecorder(), 用户:price_type, 出价:level_fir,拍品:item_index,拍牌:price_user_bid}, new uint(0));
				}
			}else{
				dealDataProvider.removeItemAt(new uint(status_counter_max)-1);
				if(price_user_id == account_id){
					dealDataProvider.addItemAt({flag:"0", 时间:getDateStatusRecorder(), 用户:price_type, 出价:level_fir,拍品:item_index,拍牌:price_user_bid}, new uint(0));
				}else{
					dealDataProvider.addItemAt({flag:"0", 时间:getDateStatusRecorder(), 用户:price_type, 出价:level_fir,拍品:item_index,拍牌:price_user_bid}, new uint(0));
				}
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
		}
		private function setPicList():void{
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