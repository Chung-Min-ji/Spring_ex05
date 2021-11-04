package org.zerock.mapper;

import org.zerock.domain.BoardAttachVO;

import java.util.List;

public interface BoardAttachMapper {

    public void insert(BoardAttachVO vo);
    public void delete(String uuid);
    public List<BoardAttachVO> findByBno(Long bno);     // 특정 게시물 번호로 첨부파일 찾기
} //end interface
