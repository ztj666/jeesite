package com.qhwl.common.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.util.UriUtils;

import com.itextpdf.kernel.pdf.PdfArray;
import com.itextpdf.kernel.pdf.PdfDictionary;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfName;
import com.itextpdf.kernel.pdf.PdfObject;
import com.itextpdf.kernel.pdf.PdfReader;
import com.itextpdf.kernel.pdf.PdfResources;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.kernel.pdf.canvas.PdfCanvas;
import com.qhwl.common.config.Global;
import com.qhwl.common.utils.FileUtils;

/**
 * 查看CK上传的图片
 * 
 * @author Admin
 * @version 2014-06-25
 */
public class UserfilesDownloadServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private Logger logger = LoggerFactory.getLogger(getClass());

	public void fileOutputStream(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String filepath = req.getRequestURI();
		int index = filepath.indexOf(Global.USERFILES_BASE_URL);
		if (index >= 0) {
			filepath = filepath.substring(index + Global.USERFILES_BASE_URL.length());
		}
		try {
			filepath = UriUtils.decode(filepath, "UTF-8");
		} catch (UnsupportedEncodingException e1) {
			logger.error(String.format("解释文件路径失败，URL地址为%s", filepath), e1);
		}
		File file = new File(Global.getUserfilesBaseDir() + Global.USERFILES_BASE_URL + filepath);

		try {
			if (FileUtils.fileSuff(filepath).equalsIgnoreCase("pdf") && req.getParameter("isPdf") != null
					&& req.getParameter("isPdf").equals("0")) {
				// PdfWriter writer = new PdfWriter(resp.getOutputStream());
				// //Initialize PDF document
				// PdfDocument pdfDoc = new PdfDocument(writer);
				// SpringContextHolder.getBean(MemberUserService.class);
				PdfDocument pdfDoc = new PdfDocument(
						new PdfReader(Global.getUserfilesBaseDir() + Global.USERFILES_BASE_URL + filepath),
						new PdfWriter(resp.getOutputStream()));
				PdfObject obj;
				List<Integer> streamLengths = new ArrayList<>();
				logger.debug("+++++++++++++++++++++" + pdfDoc.getNumberOfPages());
				List<Integer> pages = new ArrayList<>();
				int n = pdfDoc.getNumberOfPages();
				PdfDictionary page;
				PdfArray media;
				for (int p = 6; p <= n; p++) {
					page = pdfDoc.getPage(p).getPdfObject();
					media = page.getAsArray(PdfName.CropBox);
					if (media == null) {
						media = page.getAsArray(PdfName.MediaBox);
					}
					float llx = media.getAsNumber(0).floatValue() + 1400;
					float lly = media.getAsNumber(1).floatValue() + 1400;
					float w = media.getAsNumber(2).floatValue() - media.getAsNumber(0).floatValue() - 400;
					float h = media.getAsNumber(3).floatValue() - media.getAsNumber(1).floatValue() - 400;
					// !IMPORTANT to write Locale
					String command = String.format(Locale.ENGLISH, "\nq %.2f %.2f %.2f %.2f re W n\nq\n", llx, lly, w,
							h);
					new PdfCanvas(pdfDoc.getPage(p).newContentStreamBefore(), new PdfResources(), pdfDoc)
							.writeLiteral(command);
					new PdfCanvas(pdfDoc.getPage(p).newContentStreamAfter(), new PdfResources(), pdfDoc)
							.writeLiteral("\nQ\nQ\n");
				}
				pdfDoc.close();
				// pages.add(1);pages.add(2);pages.add(3);pages.add(4);pages.add(5);
				// pdfDoc.copyPagesTo(pages , pdfDoc);
				// LocationTextExtractionStrategy strategy = new
				// LocationTextExtractionStrategy();
				//
				// PdfCanvasProcessor parser = new PdfCanvasProcessor(strategy);
				// parser.processPageContent(pdfDoc.getFirstPage());
				// byte[] array = strategy.getResultantText().getBytes("UTF-8");
				// FileCopyUtils.copy(new FileInputStream(new
				// File(Global.getUserfilesBaseDir() + Global.USERFILES_BASE_URL
				// + filepath)), resp.getOutputStream());
				// for (int i = 1; i <= (pdfDoc.getNumberOfPages() > 5 ? 5 :
				// pdfDoc.getNumberOfPages()); i++) {
				// obj = pdfDoc.getPdfObject(i);
				// if (obj != null && obj.isStream()) {
				// byte[] b;
				// try {
				// b = ((PdfStream) obj).getBytes();
				// } catch (PdfException exc) {
				// b = ((PdfStream) obj).getBytes(false);
				// }
				// System.out.println(b.length);
				// // FileOutputStream fos = new
				// // FileOutputStream(String.format("", i));
				// // fos.write(b);
				// FileCopyUtils.copy(b, resp.getOutputStream());
				// streamLengths.add(b.length);
				// // fos.close();
				// }
				// }
				// Assert.assertArrayEquals(new Integer[] { 30965, 74 },
				// streamLengths.toArray(new Integer[streamLengths.size()]));
			} else
				FileCopyUtils.copy(new FileInputStream(file), resp.getOutputStream());
			resp.setHeader("Content-Type", "application/octet-stream");
			return;
		} catch (FileNotFoundException e) {
			req.setAttribute("exception", new FileNotFoundException("请求的文件不存在"));
			req.getRequestDispatcher("/WEB-INF/views/error/404.jsp").forward(req, resp);
		}
	}

	/**
	 * @author viralpatel.net
	 * 
	 * @param inputStream
	 *            Input PDF file
	 * @param outputStream
	 *            Output PDF file
	 * @param fromPage
	 *            start page from input PDF file
	 * @param toPage
	 *            end page from input PDF file PdfDocument resultDoc = new
	 *            PdfDocument(new PdfWriter(dest));
	 *            resultDoc.initializeOutlines();
	 * 
	 *            List<Integer> pages = new ArrayList<>(); pages.add(1); for
	 *            (int i = 13; i <= 15; i++) { pages.add(i); } for (int i = 2; i
	 *            <= 12; i++) { pages.add(i); } pages.add(16);
	 *            srcDoc.copyPagesTo(pages, resultDoc);
	 */
	// public static void splitPDF(InputStream inputStream,
	// OutputStream outputStream, int fromPage, int toPage) {
	// Document document = new Document();
	// try {
	// PdfReader inputPDF = new PdfReader(inputStream);
	//
	// int totalPages = inputPDF.getNumberOfPages();
	//
	// //make fromPage equals to toPage if it is greater
	// if(fromPage > toPage ) {
	// fromPage = toPage;
	// }
	// if(toPage > totalPages) {
	// toPage = totalPages;
	// }
	//
	// // Create a writer for the outputstream
	// PdfWriter writer = PdfWriter.getInstance(document, outputStream);
	//
	// document.open();
	// PdfContentByte cb = writer.getDirectContent(); // Holds the PDF data
	// PdfImportedPage page;
	//
	// while(fromPage <= toPage) {
	// document.newPage();
	// page = writer.getImportedPage(inputPDF, fromPage);
	// cb.addTemplate(page, 0, 0);
	// fromPage++;
	// }
	// outputStream.flush();
	// document.close();
	// outputStream.close();
	// } catch (Exception e) {
	// e.printStackTrace();
	// } finally {
	// if (document.isOpen())
	// document.close();
	// try {
	// if (outputStream != null)
	// outputStream.close();
	// } catch (IOException ioe) {
	// ioe.printStackTrace();
	// }
	// }
	// }
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		fileOutputStream(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		fileOutputStream(req, resp);
	}
}
