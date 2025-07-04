// QnaDAO.java
package com.spring.app.board.qna;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * QnaDAO: MyBatis Mapper를 호출하여 CRUD를 담당하는 계층입니다.
 */
@Mapper
public interface QnaDAO {
    /** 원글/답글 삽입 */
    int insertQna(QnaVO vo) throws Exception;

    /** 답글 작성 전 같은 그룹 내 step 밀어내기 */
    void updateStepForReply(@Param("boardRef") Long boardRef, @Param("boardStep") Long boardStep) throws Exception;


    /** 전체 게시물 수 조회 (페이징용) */
    int selectQnaCount() throws Exception;

    /** 페이징 처리된 게시물 목록 조회 */
    List<QnaVO> selectQnaList(Map<String, Object> params) throws Exception;

    /** 특정 글 상세 조회 */
    QnaVO selectQnaById(Long boardNum) throws Exception;

    /** 글 수정 (제목, 내용, isSecret) */
    int updateQna(QnaVO vo) throws Exception;

    /** 글 삭제 */
    int deleteQna(Long boardNum) throws Exception;
}
