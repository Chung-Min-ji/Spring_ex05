package org.zerock.mapper;

import org.zerock.domain.BoardAttachVO;

import java.util.List;

public interface BoardAttachMapper {

    public void insert(BoardAttachVO vo);
    public void delete(String uuid);        // 첨부파일 삭제(DB)
    public List<BoardAttachVO> findByBno(Long bno);     // 특정 게시물 번호로 첨부파일 찾기
    public void deleteAll(Long bno);        // 첨부파일 삭제(DB + 로컬의 원본 파일)
} //end interface
