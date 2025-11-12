package com.spring.springProject1.common;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springProject1.board.dao.BoardDao;

@Service
public class Pagination {

	@Autowired
	BoardDao boardDao;

	public PageVo getTotRecCnt(int pag, int pageSize, String section) {
		PageVo vo = new PageVo();

		int totRecCnt = 0;

		if(section.equals("board")) {
			totRecCnt = boardDao.getBoardTotRecCnt(); // 전체 게시글 수
		}

		int totPage = (totRecCnt % pageSize) == 0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;

		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;

		vo.setPag(pag);
		vo.setPageSize(pageSize);
		vo.setTotRecCnt(totRecCnt);
		vo.setTotPage(totPage);
		vo.setStartIndexNo(startIndexNo);
		vo.setCurScrStartNo(curScrStartNo);
		vo.setBlockSize(blockSize);
		vo.setCurBlock(curBlock);
		vo.setLastBlock(lastBlock);

		return vo;
	}
	
	public PageVo getPageVo(int pag, int pageSize, int totRecCnt) {
    PageVo vo = new PageVo();

    int totPage = (totRecCnt % pageSize == 0) ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1;
    int startIndexNo = (pag - 1) * pageSize;
    int curScrStartNo = totRecCnt - startIndexNo;

    int blockSize = 3;
    int curBlock = (pag - 1) / blockSize;
    int lastBlock = (totPage - 1) / blockSize;

    vo.setPag(pag);
    vo.setPageSize(pageSize);
    vo.setTotRecCnt(totRecCnt);
    vo.setTotPage(totPage);
    vo.setStartIndexNo(startIndexNo);
    vo.setCurScrStartNo(curScrStartNo);
    vo.setBlockSize(blockSize);
    vo.setCurBlock(curBlock);
    vo.setLastBlock(lastBlock);

    return vo;
	}
	
	
	
}
