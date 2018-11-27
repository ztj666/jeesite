/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.common.image;

/**
 * 图像信息
 * 图片的宽、高 、类型
 * @author zhaolei 2013-4-28
 */
public class ImageInfo {
	private int width;// 图片宽
	private int height;// 图片高
	private String format;// 图片格式,全小写，如：jpg\png\gif\bmp，jpeg表示为jpg

	public int getWidth() {
		return width;
	}

	public void setWidth(int width) {
		this.width = width;
	}

	public int getHeight() {
		return height;
	}

	public void setHeight(int height) {
		this.height = height;
	}

	public String getFormat() {
		return format;
	}

	public void setFormat(String format) {
		this.format = format;
	}
}
