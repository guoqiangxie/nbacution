package com.useeasy.auction.util.ebank;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.bocom.netpay.b2cAPI.BOCOMB2CClient;
import com.bocom.netpay.b2cAPI.BOCOMB2COPReply;
import com.bocom.netpay.b2cAPI.BOCOMSetting;
import com.bocom.netpay.b2cAPI.OpResultSet;
import com.useeasy.auction.action.GuestApplicationAction;

public class PayMent {

	static final Logger logger = LoggerFactory.getLogger(GuestApplicationAction.class);
	
	/**
	 * 创建支付
	 * 
	 * @throws UnsupportedEncodingException
	 * */
	public static String merchant(PayBean payBean) {
		BOCOMB2CClient client = new BOCOMB2CClient();
		int ret = client.initialize("c:\\bocommjava\\ini\\B2CMerchant.xml"); // 该代码只需调用一次
		if (ret != 0) { // 初始化失败
			logger.info("初始化失败,错误信息：" + client.getLastErr());
			return "error";
		}else{
			logger.info(payBean.getOrderContent());
			payBean.setSourceMsg(payBean.getInterfaceVersion() + "|"
					+ payBean.getMerID() + "|" + payBean.getOrderid() + "|"
					+ payBean.getOrderDate() + "|" + payBean.getOrderTime() + "|"
					+ payBean.getTranType() + "|" + payBean.getAmount() + "|"
					+ payBean.getCurType() + "|" + payBean.getOrderContent() + "|"
					+ payBean.getOrderMono() + "|" + payBean.getPhdFlag() + "|"
					+ payBean.getNotifyType() + "|" + payBean.getMerURL() + "|"
					+ payBean.getGoodsURL() + "|" + payBean.getJumpSeconds() + "|"
					+ payBean.getPayBatchNo() + "|" + payBean.getProxyMerName()
					+ "|" + payBean.getProxyMerType() + "|"
					+ payBean.getProxyMerCredentials() + "|" + payBean.getNetType());
	
			com.bocom.netpay.b2cAPI.NetSignServer nss = new com.bocom.netpay.b2cAPI.NetSignServer();
			String merchantDN = (String) BOCOMSetting.dnmap.get(payBean.getMerID());
			try {
				nss.NSSetPlainText(payBean.getSourceMsg().getBytes("GBK"));
				byte bSignMsg[] = nss.NSDetachedSign(merchantDN);
				if (nss.getLastErrnum() < 0) {
					logger.info("ERROR:商户端签名失败");
					return "error";
				}
				String signMsg = new String(bSignMsg, "GBK");
				payBean.setSignMsg(signMsg);
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				logger.info("出现错误");
				return "error";
			}
		}
		return BOCOMSetting.OrderURL;
	}

	/**
	 * 支付查询
	 * */
	public static List<PaySearchBean> batchorderquery(String merchantid,
			String orders) {
		//int showdetail = 0;

		String code, err, msg;
		List<PaySearchBean> list = new ArrayList<PaySearchBean>();// 所查订单返回的信息
		
		BOCOMB2CClient client = new BOCOMB2CClient();
		int ret = client.initialize("c:\\bocommjava\\ini\\B2CMerchant.xml"); // 该代码只需调用一次
		if (ret != 0) { // 初始化失败
			logger.info("初始化失败,错误信息：" + client.getLastErr());
		} else {
			BOCOMB2COPReply rep = client.queryOrder(merchantid, orders); // 批量订单查询
			if (rep == null) {
				err = client.getLastErr();
				logger.info("交易错误信息：" + err + "<br>");
			} else {
				code = rep.getRetCode(); // 得到交易返回码
				err = rep.getLastErr();
				msg = rep.getErrorMessage();
				logger.info("交易返回码：" + code);
				logger.info("交易错误信息：" + msg);
				if ("0".equals(code)) { // 表示交易成功
					//String num;
					int index;
					OpResultSet oprSet = rep.getOpResultSet();
					int iNum = oprSet.getOpresultNum();
					logger.info("总交易记录数：");
					logger.info("" + iNum);
					for (index = 0; index <= iNum - 1; index++) {
						PaySearchBean payseach = new PaySearchBean();
						payseach.setOrder(oprSet.getResultValueByName(index,
								"order")); // 订单号
						payseach.setOrderDate(oprSet.getResultValueByName(
								index, "orderDate")); // 订单日期
						payseach.setOrderTime(oprSet.getResultValueByName(
								index, "orderTime")); // 订单时间
						payseach.setCurType(oprSet.getResultValueByName(index,
								"curType")); // 币种
						payseach.setAmount(oprSet.getResultValueByName(index,
								"amount")); // 金额
						payseach.setTranDate(oprSet.getResultValueByName(index,
								"tranDate")); // 交易日期
						payseach.setTranTime(oprSet.getResultValueByName(index,
								"tranTime")); // 交易时间
						payseach.setTranState(oprSet.getResultValueByName(
								index, "tranState")); // 支付交易状态
						payseach.setOrderState(oprSet.getResultValueByName(
								index, "orderState")); // 订单状态
						payseach.setFee(oprSet.getResultValueByName(index,
								"fee")); // 手续费
						payseach.setBankSerialNo(oprSet.getResultValueByName(
								index, "bankSerialNo")); // 银行流水号
						payseach.setBankBatNo(oprSet.getResultValueByName(
								index, "bankBatNo")); // 银行批次号
						payseach.setCardType(oprSet.getResultValueByName(index,
								"cardType")); // 交易卡类型0:借记卡 1：准贷记卡 2:贷记卡
						payseach.setMerchantBatNo(oprSet.getResultValueByName(
								index, "merchantBatNo")); // 商户批次号
						payseach.setMerchantComment(oprSet
								.getResultValueByName(index, "merchantComment")); // 商户备注
						payseach.setBankComment(oprSet.getResultValueByName(
								index, "bankComment")); // 银行备注
						list.add(payseach);
					}
				}
			}

		}
		return list;
	}

	/**
	 * 查找所有的证书
	 * 
	 * */
	/*public List<String> findKeys() {
		List<String> list = null;
		java.util.Enumeration eu = BOCOMSetting.dnmap.keys();

		while (eu.hasMoreElements()) {

			String merchantid = (String) eu.nextElement();
			list.add(merchantid);

		}
		return list;
	}*/

}
