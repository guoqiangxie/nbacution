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
	
	import flash.media.*;
	
	public class Console extends MovieClip {
		
        private var socket:Socket;
		
		private var param:Object = root.loaderInfo.parameters;
		
		private var auction_port:String;
		private var auction_id:String;
		private var account_id:String;
		private var xml_num:String;
		private var auction_name:String;
		private var auction_num:String;
		
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
		
		//private var base_url:String = "http://172.16.171.80:8180/auction_n/";
		//private var base_url:String = "http://wangpai1.staa.com.cn/";
		private var base_url:String = "http://172.16.171.80:8180";
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
		
		var dataGridFormat:TextFormat = new TextFormat("黑体",30,0x666666);
		var dataGridSpecialFormat:TextFormat = new TextFormat("黑体",30,0xff0000);
		var priceDataProvider:DataProvider = new DataProvider();
		var dealDataProvider:DataProvider = new DataProvider();
		
		//var dealAlertBox:DealAlertBox;
		var auctionCloseAlertBox:AuctionCloseAlertBox;
		var connectCloseAlertBox:ConnectCloseAlertBox;
		
		private var webPay:Sound;
		private var webClose:Sound;
		
		public function Console() {
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
			//socket.connect("114.80.68.98",new uint(auction_port));
			//socket.connect("114.80.68.98",6956);
			socket.addEventListener(Event.CONNECT,connectHandler);
		   	socket.addEventListener(Event.CLOSE,closeHandler);
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			socket.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			socket.addEventListener(ProgressEvent.SOCKET_DATA,socketDataHandler);
			//socket.timeout = 5;
		}
		
		private function setDefaultStatus():void{
			
			//auctionStatus.text = "-";
			aliveNum.text = "当前在线:-人";
			
			count_down_text.visible = false;
			deal_text.text = "成交";
			deal_text.visible = false;
			
			item_image.source = "";
			itemName.text = "拍品名称:-"; 
			
			itemUnit.text = "数量/单位:-";
			
			
			
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
				account_id = "3";
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
			if(param["auction_num"] != null){
				auction_num = param["auction_num"];
			}else{
				auction_num = "-";
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
			sendMessage("90", (auction_id + "&" + account_id + "&cn&" + auction_num + "&"));
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
						xmlProgressBar.move(320,360);
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
						/*if(item_status == "0"){
							itemCurrentPrice.htmlText = "";
						}*/
						if(price_user_bid == "null" || price_user_bid == "-1"){
							itemBidNum.text = "拍牌号:-";
						}else {
							itemBidNum.text = "拍牌号:" + price_user_bid;
						}
						webPay = new WebPaySound();
						webClose = new WebCloseSound();
						
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
						if(price_user_bid == "null" || price_user_bid == "-1"){
							itemBidNum.text = "拍牌号:-";
						}else {
							itemBidNum.text = "拍牌号:" + price_user_bid;
						}
					}else if(connect_status == "89"){
						auction_status = "1";
						setAuctionStatus();
						setDescriptionArea();
						setTitleArea();
						
					}else if(connect_status == "87"){
					}else if(connect_status == "01"){
						item_id_flag = line_array[3];
						if(item_id_flag != item_id){
							sendMessage("87", (item_id + "&"));
						}else{
							item_status = line_array[4];
							setTitleArea();
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
						}
					}else if(connect_status == "03"){
						item_id_flag = line_array[3];
						if(item_id_flag != item_id){
							sendMessage("87", (item_id + "&"));
						}else{
							pause_flag = line_array[4];
							
							setTitleArea();
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
									
								}else{
									setTitleArea();
									
								}
							}else{
								setTitleArea();
							}
							if(price_user_bid == "null" || price_user_bid == "-1"){
								itemBidNum.text = "拍牌号:-";
							}else {
								itemBidNum.text = "拍牌号:" + price_user_bid;
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
							if(price_user_bid == "null" || price_user_bid == "-1" || price_user_type == "1"){
								itemBidNum.text = "拍牌号:-";
							}else {
								itemBidNum.text = "拍牌号:" + price_user_bid;
							}
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
							priceDataProvider.removeAll();
							
							/*if(item_status == "0"){
								itemCurrentPrice.htmlText = "";
							}*/
							itemBidNum.text = "拍牌号:-";
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
						priceDataProvider.removeAll();
						/*if(item_status == "0"){
							itemCurrentPrice.htmlText = "";
						}*/
						if(price_user_bid == "null" || price_user_bid == "-1"){
							itemBidNum.text = "拍牌号:-";
						}else {
							itemBidNum.text = "拍牌号:" + price_user_bid;
						}
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
							
							//setPriceDataList();
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
							
						}
					}else if(connect_status == "14"){
						item_id_flag = line_array[3];
						if(item_id_flag != item_id){
							sendMessage("87", (item_id + "&"));
						}else{
							count_time_flag = line_array[4];
						}
					}else if(connect_status == "15"){
						item_id_flag = line_array[3];
						if(item_id_flag != item_id){
							sendMessage("87", (item_id + "&"));
						}else{
							item_status = line_array[4];
							setDescriptionArea();
							setTitleArea();
						}
					}else if(connect_status == "16"){
						item_id_flag = line_array[3];
						if(item_id_flag != item_id){
							sendMessage("87", (item_id + "&"));
						}else{
							item_status = line_array[4];
							setDescriptionArea();
							setTitleArea();
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
							if(price_user_bid == "null" || price_user_bid == "-1"){
								itemBidNum.text = "拍牌号:-";
							}else {
								itemBidNum.text = "拍牌号:" + price_user_bid;
							}
							
							if(price_user_type == "2"){
								webPay.play();
							}
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
			/*if( auction_status == "0" ){
				auctionStatus.text = "拍卖会尚未开始。。。";
			}else if( auction_status == "1" ){
				auctionStatus.text = "拍卖会正在进行。。。";
			}else if( auction_status == "2" ){
				auctionStatus.text = "拍卖会已经结束。。。";
			}*/
		}
		
		private function setAliveNum(){
			aliveNum.text = "当前在线:" + user_number + "人";
		}
		
		private function setDescriptionArea(){
			//showMedia.addEventListener(MouseEvent.CLICK,fnCallJs);
			
			//itemTitle.text = auction_name;
			itemIndex.htmlText = "<font color='#000000' size='30' face='黑体'>拍品号:</font><b><font color='#FF0000' size='70' face='Arial'>" + item_order + "</font></b>";
			
			var request:URLRequest = new URLRequest(item_pic_url.substr(1,item_pic_url.length));
            item_image.load(request);
			item_image.addEventListener(IOErrorEvent.IO_ERROR, ioErrorImgHandler);
			/*request = new URLRequest("nopic.jpg");
			item_image_nopic.load(request);*/
			item_image_nopic.source = imgLoader.getContent("no_pic_main");
			item_image_nopic.visible = false;
			
			itemName.text = "拍品名称:" + item_name; 
			if(item_commission_type == "1"){
				itemCommissionValue.text = "佣金标准:固定比例";
				itemCommissionPrice.text = "佣金金额:" + item_commission_value + "%";
			}else if(item_commission_type == "2"){
				itemCommissionValue.text = "佣金标准:定额佣金";
				itemCommissionPrice.text = "佣金金额:" + item_commission_value + "元";
			}else if(item_commission_type == "3"){
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
				itemValuationType.text = "";
				itemCount.text = "元";
				//itemCount.visible = false;
			}else  if(item_valuation_method == "2"){
				itemValuationType.text = "单价";
				//itemCount.visible = true;
			}
			
			auctionName.text = auction_name;
			
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
			if(price_user_type == "1"){trace(current_val_integer.length+"dsfsf");
				priceStatusAlive.gotoAndStop(1);
				priceStatusAlive.typeTitle.htmlText = "现场出价";
				priceStatusWeb.gotoAndStop(2);
				priceStatusWeb.typeTitle.htmlText = "网络出价";
				if(current_val_integer.length > 4){
					current_val_head = current_val_integer.substr(0,current_val_integer.length-4);
					current_val_end = current_val_integer.substr(current_val_integer.length-4,current_val_integer.length) + current_val_dicemal;
					itemCurrentPrice.htmlText = "<b><font color='#00FFFF' size='96'>" + current_val_head + 
						"</font></b><b><font color='#00FFFF' size='70'>" + current_val_end + "</font></b>";
				}else{
					itemCurrentPrice.htmlText = "<b><font color='#00FFFF' size='96' face='Arial'>" + level_fir + "</font></b>"; 
				}
			}else if(price_user_type == "2"){
				priceStatusAlive.gotoAndStop(2);
				priceStatusAlive.typeTitle.htmlText = "现场出价";
				priceStatusWeb.gotoAndStop(1);
				priceStatusWeb.typeTitle.htmlText = "网络出价";
				if(current_val_integer.length > 4){
					current_val_head = current_val_integer.substr(0,current_val_integer.length-4);
					current_val_end = current_val_integer.substr(current_val_integer.length-4,current_val_integer.length) + current_val_dicemal;
					itemCurrentPrice.htmlText = "<b><font color='#FFF000' size='96'>" + current_val_head + 
						"</font></b><b><font color='#FFF000' size='70'>" + current_val_end + "</font></b>";
				}else{
					itemCurrentPrice.htmlText = "<b><font color='#FFF000' size='96' face='Arial'>" + level_fir + "</font></b>"; 
				}
			}else{
				priceStatusAlive.gotoAndStop(2);
				priceStatusAlive.typeTitle.htmlText = "现场出价";
				priceStatusWeb.gotoAndStop(2);
				priceStatusWeb.typeTitle.htmlText = "网络出价";
				if(current_val_integer.length > 4){
					current_val_head = current_val_integer.substr(0,current_val_integer.length-4);
					current_val_end = current_val_integer.substr(current_val_integer.length-4,current_val_integer.length) + current_val_dicemal;
					itemCurrentPrice.htmlText = "<b><font color='#FFFFFF' size='96'>" + current_val_head + 
						"</font></b><b><font color='#FFFFFF' size='70'>" + current_val_end + "</font></b>";
				}else{
					itemCurrentPrice.htmlText = "<b><font color='#FFFFFF' size='96' face='Arial'>" + level_fir + "</font></b>"; 
				}
			}
			
			if(item_status == "0"){
				itemStatus.text = "尚未开始";
				deal_text.visible = false;
			}else if(item_status == "1"){
				itemStatus.text = "正在进行";
				deal_text.visible = false;
			}else if(item_status == "2"){
				itemStatus.text = "正在进行";
				deal_text.visible = false;
			}else if(item_status == "3"){
				itemStatus.text = "正在进行";
				deal_text.visible = false;
			}else if(item_status == "4"){
				itemStatus.text = "网络关闭";
				deal_text.visible = false;
			}else if(item_status == "5"){
				itemStatus.text = "成交";
				deal_text.visible = true;
			}else if(item_status == "6"){
				itemStatus.text = "流标";
				deal_text.visible = false;
				itemCurrentPrice.htmlText = "<font color='#FFF000' size='96' face='黑体'>流标</font>"; 
			}else if(item_status == "7"){
				itemStatus.text = "撤拍";
				deal_text.visible = false;
				itemCurrentPrice.htmlText = "<font color='#FFF000' size='96' face='黑体'>撤拍</font>"; 
			}else if(item_status == "8"){
				itemStatus.text = "缓拍";
				deal_text.visible = false;
				itemCurrentPrice.htmlText = "<font color='#FFF000' size='96' face='黑体'>缓拍</font>"; 
			}
			
			if(pause_flag == "1"){
				itemStatus.text = "暂停";
				deal_text.visible = false;
			}
		}
		
		public function countdown(e:TimerEvent):void{
			count_down_text.visible = true;
			count_down_text.text = "" + count_down_time;
			count_down_time--;
			if(count_down_time == -1){
				itemStatus.text = "网络关闭";
				count_down_text.visible = false;
				webClose.play();
			}
		}
		
		
	}
}