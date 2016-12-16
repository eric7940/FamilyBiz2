package com.fb.service.impl;

import java.util.List;

import com.fb.service.CommonService;
import com.fb.util.FamilyBizException;
import com.fb.vo.LookupVO;

public class CommonServiceImpl extends ServiceImpl implements CommonService {

	@SuppressWarnings("unchecked")
	public List<LookupVO> getUnits() throws FamilyBizException {
		LookupVO lookup = new LookupVO();
		lookup.setType("UNIT");
		lookup.setDisplay(true);
		return this.getFbDao().queryForList("selectLookup", lookup);
	}

	public String getOfferDefaultMemo() throws FamilyBizException {
		LookupVO lookup = new LookupVO();
		lookup.setType("OFFER_MEMO");
		lookup.setDisplay(true);
		
		String memo = "";
		LookupVO result = (LookupVO) this.getFbDao().queryForObject("selectLookup", lookup);
		if (result != null) {
			memo = result.getValue();
		}
		return memo;
	}
	
	public void modifyOfferDefaultMemo(String memo) throws FamilyBizException {
		LookupVO lookup = new LookupVO();
		lookup.setType("OFFER_MEMO");
		this.getFbDao().delete("deleteLookup", lookup);

		lookup.setCode("");
		lookup.setValue(memo);
		lookup.setDisplay(true);
		lookup.setDisplayOrder(0);
		lookup.setDesc("出貨單附註");
		this.getFbDao().insert("insertLookup", lookup);
	}
	
	public void modifyUnits(List<String> units) throws FamilyBizException {
		LookupVO lookup = new LookupVO();
		lookup.setType("UNIT");
		this.getFbDao().delete("deleteLookup", lookup);

		for(int i = 0; i < units.size(); i++) {
			int idx = i + 1;
			lookup.setCode("UT-" + idx);
			lookup.setValue((String)units.get(i));
			lookup.setDisplay(true);
			lookup.setDisplayOrder(idx);
			lookup.setDesc("單位-" + (String)units.get(i));
			this.getFbDao().insert("insertLookup", lookup);
		}
	}	
}
