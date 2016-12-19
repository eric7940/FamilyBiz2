package com.fb.util;

public class RowBounds {
	
	public static final RowBounds DEFAULT = new RowBounds();

	public static final int NO_ROW_LIMIT = Integer.MAX_VALUE;
	public static final int NO_ROW_OFFSET = 0;

	private int limit;
	private int offset;
	
	public RowBounds() {
		this.offset = NO_ROW_OFFSET;
	    this.limit = NO_ROW_LIMIT;
	}
	
	public RowBounds(int offset, int limit) {
		this.offset = offset;
		this.limit = limit;
	}

	public int getLimit() {
		return limit;
	}

	public int getOffset() {
		return offset;
	}
	
	
}
