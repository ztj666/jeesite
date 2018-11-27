
package com.qhwl.common.image;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.Transparency;
import java.awt.color.ColorSpace;
import java.awt.image.BufferedImage;
import java.awt.image.ColorModel;
import java.awt.image.ComponentColorModel;
import java.awt.image.DataBuffer;
import java.awt.image.DataBufferByte;
import java.awt.image.Raster;
import java.awt.image.RenderedImage;
import java.awt.image.WritableRaster;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.Iterator;

import javax.imageio.IIOImage;
import javax.imageio.ImageIO;
import javax.imageio.ImageReader;
import javax.imageio.ImageWriteParam;
import javax.imageio.ImageWriter;
import javax.imageio.metadata.IIOMetadata;
import javax.imageio.stream.ImageInputStream;
import javax.imageio.stream.ImageOutputStream;

/**
 * 纯Java处理CMYK格式(32位色深)的JPEG文件 的工具类
 * 
 * 直接使用ImageIO.read()读取图片，可正常处理24位色深的图片，但在处理32位色深的图片时会报错。
 * ImageCMYK工具类，就是用来解决这个问题的，可以正常读取 24位、32位色深的图片
 * 
 * @author 赵磊
 */
public class ImageCMYK {

    /**
     * 将一个图片文件读入内存（兼容24位、32位色深的图片）
     * 
     * @param img
     *            图片文件
     * @return 图片对象
     */
    public static BufferedImage read(Object img) {
        try {
            if (img instanceof CharSequence) {
                return ImageIO.read(new File(img.toString()));
            }
            if (img instanceof File)
                return ImageIO.read((File) img);

            if (img instanceof URL)
                img = ((URL) img).openStream();

            if (img instanceof InputStream) {
//                File tmp = File.createTempFile("nutz_img", ".jpg");
//                Files.write(tmp, (InputStream) img);
//                try {
//                    return read(tmp);
//                }
//                finally {
//                    tmp.delete();
//                }
            	return ImageIO.read((InputStream) img);
            }
            throw new RuntimeException("Unkown img info!! --> " + img);
        }
        catch (IOException e) {
        	//当走到这里，说明是CMYK格式(32位色深)的JPEG文件，要特殊处理
            try {
                InputStream in = null;
                if (img instanceof File)
                    in = new FileInputStream((File) img);
                else if (img instanceof URL)
                    in = ((URL) img).openStream();
                else if (img instanceof InputStream)
                    in = (InputStream) img;
                if (in != null)
                    return readJpeg(in);
            }
            catch (IOException e2) {
                e2.fillInStackTrace();
            }
            return null;
            // throw Lang.wrapThrow(e);
        }
    }

    /**
     * 写入一个 JPG 图像
     * 
     * @param im
     *            图像对象
     * @param targetJpg
     *            目标输出 JPG 图像文件
     * @param quality
     *            质量 0.1f ~ 1.0f
     */
    public static void writeJpeg(RenderedImage im, Object targetJpg, float quality) {
        try {
            ImageWriter writer = ImageIO.getImageWritersBySuffix("jpg").next();
            ImageWriteParam param = writer.getDefaultWriteParam();
            param.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);
            param.setCompressionQuality(quality);
            ImageOutputStream os = ImageIO.createImageOutputStream(targetJpg);
            writer.setOutput(os);
            writer.write((IIOMetadata) null, new IIOImage(im, null, null), param);
            os.flush();
            os.close();
        }
        catch (IOException e) {
        	throw new RuntimeException("写入一个 JPG 图像异常",e);
            //throw Lang.wrapThrow(e);
        }
    }

    /**
     * 尝试读取JPEG文件的高级方法,可读取32位的jpeg文件
     * <p/>
     * 来自:
     * http://stackoverflow.com/questions/2408613/problem-reading-jpeg-image-
     * using-imageio-readfile-file
     * 
     */
    static BufferedImage readJpeg(InputStream in) throws IOException {
        Iterator<ImageReader> readers = ImageIO.getImageReadersByFormatName("JPEG");
        ImageReader reader = null;
        while (readers.hasNext()) {
            reader = (ImageReader) readers.next();
            if (reader.canReadRaster()) {
                break;
            }
        }
        ImageInputStream input = ImageIO.createImageInputStream(in);
        reader.setInput(input);
        // Read the image raster
        Raster raster = reader.readRaster(0, null);
        BufferedImage image = createJPEG4(raster);
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        writeJpeg(image, out, 1);
        out.flush();
        return read(new ByteArrayInputStream(out.toByteArray()));
    }

    /**
     * Java's ImageIO can't process 4-component images and Java2D can't apply
     * AffineTransformOp either, so convert raster data to RGB. Technique due to
     * MArk Stephens. Free for any use.
     */
    private static BufferedImage createJPEG4(Raster raster) {
        int w = raster.getWidth();
        int h = raster.getHeight();
        byte[] rgb = new byte[w * h * 3];

        float[] Y = raster.getSamples(0, 0, w, h, 0, (float[]) null);
        float[] Cb = raster.getSamples(0, 0, w, h, 1, (float[]) null);
        float[] Cr = raster.getSamples(0, 0, w, h, 2, (float[]) null);
        float[] K = raster.getSamples(0, 0, w, h, 3, (float[]) null);

        for (int i = 0, imax = Y.length, base = 0; i < imax; i++, base += 3) {
            float k = 220 - K[i], y = 255 - Y[i], cb = 255 - Cb[i], cr = 255 - Cr[i];

            double val = y + 1.402 * (cr - 128) - k;
            val = (val - 128) * .65f + 128;
            rgb[base] = val < 0.0 ? (byte) 0 : val > 255.0 ? (byte) 0xff : (byte) (val + 0.5);

            val = y - 0.34414 * (cb - 128) - 0.71414 * (cr - 128) - k;
            val = (val - 128) * .65f + 128;
            rgb[base + 1] = val < 0.0 ? (byte) 0 : val > 255.0 ? (byte) 0xff : (byte) (val + 0.5);

            val = y + 1.772 * (cb - 128) - k;
            val = (val - 128) * .65f + 128;
            rgb[base + 2] = val < 0.0 ? (byte) 0 : val > 255.0 ? (byte) 0xff : (byte) (val + 0.5);
        }

        raster = Raster.createInterleavedRaster(new DataBufferByte(rgb, rgb.length),
                                                w,
                                                h,
                                                w * 3,
                                                3,
                                                new int[]{0, 1, 2},
                                                null);

        ColorSpace cs = ColorSpace.getInstance(ColorSpace.CS_sRGB);
        ColorModel cm = new ComponentColorModel(cs,
                                                false,
                                                true,
                                                Transparency.OPAQUE,
                                                DataBuffer.TYPE_BYTE);
        return new BufferedImage(cm, (WritableRaster) raster, true, null);
    }

    
    /**
     * 在一个RGB画布上重新绘制Image,解决CMYK图像偏色的问题
     */
    public static BufferedImage redraw(BufferedImage img, Color bg) {
        BufferedImage rgbImage = new BufferedImage(img.getWidth(), img.getHeight(), BufferedImage.TYPE_3BYTE_BGR);
        Graphics2D g2d = rgbImage.createGraphics();
        g2d.drawImage(img, 0, 0, bg, null);
        g2d.dispose();
        return rgbImage;
    }
}