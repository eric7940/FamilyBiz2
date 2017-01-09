package com.fb.web.form.element;

import java.io.Serializable;
import java.util.List;

import org.apache.log4j.Logger;

import com.fb.util.ConstUtil;

public class PageElement implements Serializable {

	private static final long serialVersionUID = 4215540543142030727L;
	
	private static final Logger logger = Logger.getLogger(PageElement.class);
	
	private List<?> records = null;

	private int pageSize = ConstUtil.QUERY_PAGE_SIZE;
	private int liSize = ConstUtil.QUERY_LI_SIZE;

	private int currentPage = 1;
	private long totalRecord = 0;
	private int totalPage = 0;
	private int start = 0;
	private int end = 0;
	
	private boolean movePage = false;

	public PageElement() {
	}

	public PageElement(int totalRecord, int currentPage, int pageSize) {
		this.totalRecord = totalRecord;
		this.currentPage = currentPage;
		this.pageSize = pageSize;
		this.totalPage = (int) Math.ceil((double) this.totalRecord / this.pageSize);

		if (currentPage > totalPage)
			this.currentPage = 1;
		
		this.start = (this.currentPage - 1) * this.pageSize;

		if (this.start <= 0)
			this.start = 0;
		
		if (logger.isDebugEnabled()) {
			logger.debug("[pagination] totalRecord=" + this.totalRecord);
			logger.debug("[pagination] currentPage=" + this.currentPage);
			logger.debug("[pagination] pageSize=" + this.pageSize);
			logger.debug("[pagination] totalPage=" + this.totalPage);
			logger.debug("[pagination] start=" + this.start);
		}
	}

	public List<?> getRecords() {
		return records;
	}

	public void setRecords(List<?> records) {
		this.records = records;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public long getTotalRecord() {
		return totalRecord;
	}

	public void setTotalRecord(long totalRecord) {
		this.totalRecord = totalRecord;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getLiSize() {
		return liSize;
	}

	public void setLiSize(int liSize) {
		this.liSize = liSize;
	}

	public boolean getMovePage() {
		return movePage;
	}

	public void setMovePage(boolean movePage) {
		this.movePage = movePage;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getEnd() {
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}
	
}
