package com.systex.emp.manager.util;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;

/**
 * Excel操作工具 http://poi.apache.org/spreadsheet/quick-guide.html
 * 
 * @author hebe
 */
public class ExcelUtil {

	/**
	 * 增加[跨欄]
	 * 
	 * @param worksheet 工作表
	 * @param firstRow 列(起)
	 * @param lastRow 列(迄)
	 * @param firstColumn 欄(起)
	 * @param lastColumn 欄(迄)
	 */
	public static void addMergedRegion(Sheet worksheet, int firstRow, int lastRow, int firstColumn, int lastColumn) {
		try {
			if (worksheet != null) {
				worksheet.addMergedRegion(new CellRangeAddress(firstRow, lastRow, firstColumn, lastColumn));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	/**
	 * 設定[列高]
	 * 
	 * @param worksheet
	 * @param rownum 列
	 * @param height 高
	 */
	public static void setHeight(Sheet worksheet, int rownum, float height) {
		try {
			if (worksheet != null) {
				Row row = worksheet.getRow(rownum);
				if (row == null) {
					row = worksheet.createRow(rownum);
				}
				row.setHeightInPoints(height);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	/**
	 * 設定欄位內容
	 * 
	 * @param worksheet 工作表
	 * @param rownum 列
	 * @param column 欄
	 * @param value 值
	 * @return
	 */
	public static void setCell(Sheet worksheet, int rownum, int cell, String value) {
		ExcelUtil.setCell(worksheet, rownum, cell, value, null);
	}

	/**
	 * 設定[欄位內容]
	 * 
	 * @param worksheet 工作表
	 * @param rownum 列
	 * @param column 欄
	 * @param value 值
	 * @param cellStyle 樣式
	 */
	public static void setCell(Sheet worksheet, int rownum, int column, String value, CellStyle cellStyle) {
		try {
			if (worksheet != null) {
				Cell cell = null;
				if (worksheet.getRow(rownum) != null) {
					cell = worksheet.getRow(rownum).createCell(column);
				} else {
					cell = worksheet.createRow(rownum).createCell(column);
				}
				cell.setCellValue(value);
				cell.setCellType(Cell.CELL_TYPE_STRING);
				if (cellStyle != null) {
					cell.setCellStyle(cellStyle);
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	
	public static Font getFont(Workbook workbook) {					
		Font font = workbook.createFont();
		font.setFontName("新細明體"); // 設定字體
		font.setFontHeightInPoints((short) 14); // 設定字體大小
		
		return font;
	}
	
	public static CellStyle getCellStyle(Workbook workbook, Font font) {					
		CellStyle cellStyle = workbook.createCellStyle();
		cellStyle.setFont(font);
		cellStyle.setFillForegroundColor(IndexedColors.PALE_BLUE.getIndex());
		cellStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
		
		return cellStyle;
	}
	
	public static CellStyle getCellStyleRequire(Workbook workbook, Font font) {					
		CellStyle cellStyle = workbook.createCellStyle();
		cellStyle.setFont(font);
		cellStyle.setFillForegroundColor(IndexedColors.CORAL.getIndex());
		cellStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
		
		return cellStyle;
	}
}
