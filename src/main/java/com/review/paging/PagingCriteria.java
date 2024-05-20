package com.review.paging;

import lombok.Data;

import java.util.Date;

@Data
public class PagingCriteria {

    /** 현제 페이지 **/
    private int pageNum;

    /** 한 페이지 당 보여질 게시물 수 **/
    private int amount;

    /** 스킵 할 게시물 수 ((pageNum-1) * amount)**/
    private int skip;

    /** 검색 키워드 **/
    private String keyword;

    /** 검색 타입**/
    private String type;

    /** 검색 타입 배열 **/
    private String[] typeArr;

    private String startTime;
    private String endTime;


    /** 기본 생성자 -> 기본 세팅 : pageNum =1, amount = 10 **/
    public PagingCriteria(){
        this(1,10);
        this.skip= 0;
    }
    /** 생성자 => 원하는 pageNum, 원하는 amount **/
    public PagingCriteria(int pageNum, int amount){
        this.pageNum = pageNum;
        this.amount = amount;
        this.skip = (pageNum - 1) * amount;
    }

    public void setPageNum(int pageNum){
        this.skip= (pageNum - 1) * this.amount;
        this.pageNum = pageNum;
    }

    public void setAmount(int amount){
        this.skip = (this.pageNum - 1) * amount;

        this.amount = amount;
    }

    public void setType(String type){
        this.type = type;
        this.typeArr = type.split("");
    }
}
