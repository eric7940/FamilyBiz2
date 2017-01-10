package com.fb.service;

import java.util.List;

import com.fb.util.FamilyBizException;
import com.fb.vo.PurchaseDetailVO;
import com.fb.vo.PurchaseMasterVO;

public interface PurchaseService extends Service {

	public PurchaseMasterVO getPurchase(String masterId) throws FamilyBizException;
	
	public List<PurchaseMasterVO> getPurchases(int factId, boolean back) throws FamilyBizException;

	public String addPurchase(PurchaseMasterVO master, List<PurchaseDetailVO> details, boolean back) throws FamilyBizException;

	public int removePurchase(PurchaseMasterVO master, boolean back) throws FamilyBizException;
}
