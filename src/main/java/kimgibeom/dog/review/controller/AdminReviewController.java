package kimgibeom.dog.review.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kimgibeom.dog.review.domain.Review;
import kimgibeom.dog.review.service.ReviewReplyService;
import kimgibeom.dog.review.service.ReviewService;

@Controller
@RequestMapping("/admin/review")
public class AdminReviewController {
	@Autowired private ReviewService reviewService;
	@Autowired private ReviewReplyService reviewReplyService;
	@Value("${reviewAttachDir}") private String attachDir;
	
	@RequestMapping("/reviewListView")
	public void readReviews(Model model, String saveFileName) {
		model.addAttribute("saveFileName", saveFileName);
		model.addAttribute("reviewList", reviewService.readReviews());
	}
	
	@RequestMapping("/reviewView")
	public String moveReviewView(Model model, @RequestParam("reviewNum") int reviewNum) {
		System.out.println(reviewNum);
		return "admin/review/reviewView";
	}
	
	@RequestMapping("/reviewRegist")
	public String moveReivewRegist() {
		return "admin/review/reviewRegist";
	}
	
	@RequestMapping(value="/addReview", method=RequestMethod.POST)
	public String addReview(String title, MultipartFile attachFile, String content,
			@ModelAttribute("review") Review review, HttpServletRequest request, RedirectAttributes rttr) {
		String dir = request.getServletContext().getRealPath(attachDir); //물리적인 경로 생성
		String attachName = attachFile.getOriginalFilename(); //원본 파일명
		
		UUID uuid = UUID.randomUUID();
		String saveFileName = uuid.toString() + "_" + attachName; //중복 파일명 방지
				
		File saveFile = new File(dir + saveFileName);
		save(attachFile, saveFile);
		
		review = new Review(title, content, saveFileName);
		rttr.addAttribute("saveFileName", saveFileName);
		reviewService.writeReview(review);
		
		return "redirect:reviewListView";
	}
	
	private void save(MultipartFile attachFile, File saveFile) {
		try { 
			attachFile.transferTo(saveFile); 
		}catch(IOException e) { 
			e.printStackTrace();
		}
	}
}