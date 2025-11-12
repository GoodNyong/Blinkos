package com.spring.springProject1.board;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.nio.file.Files;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.springProject1.board.dao.BoardDao;
import com.spring.springProject1.common.CommonDateTimeFormatter;

@Service
public class BoardServiceImpl implements BoardService {

	private static final Logger logger = LoggerFactory.getLogger(BoardServiceImpl.class);

	/*
	 * 처리 로직이 많다 (ex. 파일 저장, 반복문, 조건 분기, 예외 처리 등) ✔️ 반드시 ServiceImpl에 둬야 함 단순한 DB
	 * 작업만 수행 (ex. 아이디 중복 체크, 게시글 수 count 등) ✔️ Controller → DAO 바로 연결해도 무방 다른 도메인과
	 * 연동하거나 여러 DB 작업을 연결해야 할 때 ✔️ ServiceImpl로 분리해서 트랜잭션 처리 포함
	 */

	@Autowired
	BoardDao boardDao;
	
	//여기서 처리하는 이유
	//Controller	"누구한테 뭘 시킬지" 결정만 함 (전달자 역할)
	//Controller는 단순히 "Model에 담아서 JSP로 넘기기"만 하는 곳 코드가 더러워지면 재사용 불가
	//ServiceImpl	"데이터를 어떻게 처리해서 쓸 것인가" 결정함 (가공 처리 담당)
	//DAO/Mapper	"DB에서 어떤 raw 데이터를 가져올지" 결정함 (데이터 접근 담당)
	@Override
	public List<BoardVo> getBoardList(String category, Integer startIndexNo, Integer pageSize) {
		 List<BoardVo> vos = boardDao.getBoardList(category, startIndexNo, pageSize);
		 for (BoardVo vo : vos) {
			 vo.setFormattedTime(CommonDateTimeFormatter.FormatDateTimeOne(vo.getCreated_at()));
		 }
		 return vos;
	}
//	boardDao.getBoardList(category, startIndexNo, pageSize)를 통해
//	dao로 보내고 mapper에서 select된 vo들, 즉 게시물 데이터들을
//	ServiceImpl에서 다시 list에 담는다.
//	그 안에 있는 vo들을 향상 반복문에서 BoardVo 타입의 vo 변수에 하나씩 넣는다.
//	그리고 그 vo의 created_at 값을 common 패키지의 DateTimeAgoFormatter 클래스 안의 FormatDateTimeAgo 메서드에 매개값으로 넣고,
//	그 리턴값을 setFormattedTime으로 저장해서
//	다시 list에 담아(담는게 아니라 정확히는 굳이 담지 않아도 그 list안의 vo들을 하나씩 꺼내 formattedTime값을 새로 저장한거) Controller에 리턴한다.

	@Override
	public void imgCheck(String content) {
	    HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
	    String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");

	    int position = 35; // src="/springProject1/data/ckeditor/" 경로 기준
	    String nextImg = content.substring(content.indexOf("src=\"/") + position);
	    boolean sw = true;

	    while(sw) {
	        String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
	        
	        if (imgFile == null || imgFile.trim().equals("")) {
	          continue; // 현재 루프 건너뛰고 다음 파일 검사
	        }
	        
	        if(imgFile.startsWith("ckeditor/")) {
            imgFile = imgFile.substring("ckeditor/".length());
	        }
	        
	        String origFilePath = realPath + "ckeditor/" + imgFile;
	        String copyFilePath = realPath + "board/" + imgFile;

	        fileCopyCheck(origFilePath, copyFilePath);

	        if(nextImg.indexOf("src=\"/") == -1) sw = false;
	        else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
	    }
	}


	private void fileCopyCheck(String origFilePath, String copyFilePath) {
    try {
        File origFile = new File(origFilePath);
        File copyFile = new File(copyFilePath);

        logger.debug("File copy attempt - source: {}, target: {}", origFile.getAbsolutePath(), copyFile.getAbsolutePath());

        if(!origFile.exists()) {
            logger.warn("File copy failed - source file does not exist: {}", origFile.getAbsolutePath());
            return;
        }

        try (FileInputStream fis = new FileInputStream(origFilePath);
             FileOutputStream fos = new FileOutputStream(copyFilePath)) {

            byte[] buffer = new byte[2048];
            int length;
            while((length = fis.read(buffer)) != -1) {
                fos.write(buffer, 0, length);
            }
            fos.flush();
        }

        logger.info("File copy successful: {}", copyFile.getAbsolutePath());
    } catch (Exception e) {
        logger.error("File copy failed - exception occurred: {}", e.getMessage(), e);
    }
}

	@Override
	public int setBoardInput(BoardVo vo) {
			boardDao.setBoardInput(vo);
	    return vo.getBoard_id();
	}

	@Override
	public void setBoardFile(String content, int board_id) {
	    HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
	    String realPath = request.getSession().getServletContext().getRealPath("/resources/data/board/");

	    int position = 18;
	    
	    if(content.indexOf("src=\"/") == -1) {
	    	logger.debug("No image source found in content");
	    	return;
	    }
	    
	    
	    String nextImg = content.substring(content.indexOf("src=\"/") + position);
	    boolean sw = true;

	    while(sw) {
	      String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
	      
        if (imgFile == null || imgFile.trim().equals("")) {
          continue; // 파일명 없으면 무시
        }

	      // 🔥 폴더경로 잘라내고 파일명만 남기기
	      if(imgFile.contains("/")) {
	          imgFile = imgFile.substring(imgFile.lastIndexOf("/") + 1);
	      }

	      logger.debug("Processing image file: {}", imgFile);

	      File file = new File(realPath, imgFile);
	      logger.debug("File exists: {}", file.exists());

	      BoardFileVo fvo = new BoardFileVo();
	      fvo.setBoard_id(board_id);
	      fvo.setFile_name(imgFile);
	      fvo.setFile_url("/resources/data/board/" + imgFile);

	      try {
	          fvo.setFile_size((int) file.length());
	          fvo.setFile_type(Files.probeContentType(file.toPath()));
	      } catch (Exception e) {
	          logger.error("Failed to get file metadata: {}", e.getMessage(), e);
	      }

	      boardDao.setBoardFile(fvo);

	      if(nextImg.indexOf("src=\"/") == -1) sw = false;
	      else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
	  }
	}
	
	//게시물 조회 로그
	@Override
	public void setBoardViewLog(int board_id, int sUser_id, String host_ip) {
	    boardDao.setBoardViewLog(board_id, sUser_id, host_ip);
	}

	@Override
	public boolean checkViewDuplicate(int board_id, int sUser_id) {
		BoardViewLogVo lastBoardViewLog = boardDao.getBoardViewLog(board_id, sUser_id);
		
		if (lastBoardViewLog == null) {
      // 🔥 이전에 본 기록이 없으면 => 조회수 증가 허용
      // 👉 새로 기록 insert는 따로 해줘야 한다
      return true;
		} else {
      // 2. 만약 기록이 있다면, 마지막 본 시간이 24시간이 지났는지 체크
      LocalDateTime lastViewedTime = lastBoardViewLog.getViewed_at();
      LocalDateTime now = LocalDateTime.now();

      Duration duration = Duration.between(lastViewedTime, now);
      long minutes = duration.toMinutes(); //분 단위로 정확하게
      if (minutes >= 24 * 60) {
          return true;
      } else {
          return false;
      }
		}
	}
	
	//게시물 가져오기
	@Override
	public BoardVo getBoardContent(int board_id) {
		BoardVo vo = boardDao.getBoardContent(board_id);
		vo.setFormattedTime(CommonDateTimeFormatter.FormatDateTimeThree(vo.getCreated_at()));
		return vo;
	}
	
	//게시물 조회수 증가
	@Override
	public void increaseReadCount(int board_id) {
		boardDao.increaseReadCount(board_id);
	}

	@Override
	public BoardVo getPreNextBoardContent(int board_id, String preNext, String category) {
		return boardDao.getPreNextBoardContent(board_id, preNext, category);
	}
	
	@Override
	public boolean checkIsLiked(Integer board_id, Integer sUser_id) {
    BoardLikeVo likeVo = boardDao.getBoardLike(board_id, sUser_id);
    return likeVo != null;
	}

	@Override
	public void deleteBoardLike(Integer board_id, Integer user_id) {
		boardDao.deleteBoardLike(board_id, user_id);
	}

	@Override
	public void decreaseLikeCount(Integer board_id) {
		boardDao.decreaseLikeCount(board_id);
	}

	@Override
	public void setBoardLike(Integer board_id, Integer user_id) {
		boardDao.setBoardLike(board_id, user_id);
	}

	@Override
	public void increaseLikeCount(Integer board_id) {
		boardDao.increaseLikeCount(board_id);
	}

	@Override
	public List<BoardCommentVo> getBoardCommentList(Integer board_id) {
		List<BoardCommentVo> commentVos = boardDao.getBoardCommentList(board_id);
	  for (BoardCommentVo vo : commentVos) {
	    vo.setFormattedTime(CommonDateTimeFormatter.FormatDateTimeTwo(vo.getCreated_at()));
	  }
		return commentVos;
	}
	@Override
	public BoardCommentVo getBoardComment(Integer comment_id) {
		return boardDao.getBoardComment(comment_id);
	}

	@Override
	public void setBoardComment(Integer board_id, Integer user_id, String username, String content, String host_ip) {
		boardDao.setBoardComment(board_id, user_id, username, content, host_ip);
	}

	@Override
	public void increaseBoardCommentCount(Integer board_id) {
		boardDao.increaseBoardCommentCount(board_id);
	}

	@Override
	public void setBoardReply(Integer comment_id, Integer user_id, String username, String content, String host_ip) {
		boardDao.setBoardReply(comment_id, user_id, username, content, host_ip);
	}

	@Override
	public List<BoardReplyVo> getBoardReplyList(Integer comment_id) {
		List<BoardReplyVo> replyVos = boardDao.getBoardReplyList(comment_id);
	  for (BoardReplyVo vo : replyVos) {
	    vo.setFormattedTime(CommonDateTimeFormatter.FormatDateTimeTwo(vo.getCreated_at()));
	  }
		return replyVos;
	}
	@Override
	public BoardReplyVo getBoardReply(Integer reply_id) {
		return boardDao.getBoardReply(reply_id);
	}

	@Override
	public void setBoardReport(String part, Integer board_id, Integer comment_id, Integer reply_id, Integer user_id, String reason) {
		boardDao.setBoardReport(part, board_id, comment_id, reply_id, user_id, reason);
	}

	@Override
	public void increaseCommentLikeCount(Integer comment_id) {
		boardDao.increaseCommentLikeCount(comment_id);
	}

	@Override
	public int setBoardDelete(int board_id) {
		return boardDao.setBoardDelete(board_id);
	}

	@Override
	public int setBoardCommentDelete(Integer comment_id) {
		return boardDao.setBoardCommentDelete(comment_id);
	}

	@Override
	public int setBoardReplyDelete(Integer reply_id) {
		return boardDao.setBoardReplyDelete(reply_id);
	}

	@Override
	public int getBoardtotRecCntByUser(int user_id) {
		return boardDao.getBoardtotRecCntByUser(user_id);
	}

	@Override
	public List<BoardVo> getBoardListByUser(int user_id, int startIndexNo, int pageSize) {
		List<BoardVo> vos = boardDao.getBoardListByUser(user_id, startIndexNo, pageSize);
		for(BoardVo vo : vos) {
			vo.setFormattedTime(CommonDateTimeFormatter.FormatDateTimeThree(vo.getCreated_at()));
		}
		return vos;
	}

}
