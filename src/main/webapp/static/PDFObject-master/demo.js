 var options = {
				pdfOpenParams: {
					pagemode: "thumbs",
					navpanes: 0,
					toolbar: 0,
					statusbar: 0,
					view: "FitV"
				}
			};
 //<div id="pdf"></div>
var myPDF = PDFObject.embed("http://ztj.tunnel.qydev.com/userfiles/1/files/industry/industryResource/2016/09/%E7%AC%AC%E5%8D%81%E5%B1%8A%E5%85%A8%E5%9B%BD%E9%81%97%E4%BC%A0%E7%97%85%E8%AF%8A%E6%96%AD%E4%B8%8E%E4%BA%A7%E5%89%8D%E8%AF%8A%E6%96%AD%E5%AD%A6%E6%9C%AF%E4%BA%A4%E6%B5%81%E4%BC%9A%E9%80%9A%E7%9F%A5.pdf", "#pdf", options);