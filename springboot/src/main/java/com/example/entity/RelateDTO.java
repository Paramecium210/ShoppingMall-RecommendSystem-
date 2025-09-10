package com.example.entity;

public class RelateDTO {
    private Integer userId;
    private Integer goodsId;
    private Integer index;

    public RelateDTO(Integer userId,Integer goodsId,Integer index){
        this.userId = userId;
        this.goodsId = goodsId;
        this.index = index;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(Integer goodsId) {
        this.goodsId = goodsId;
    }

    public Integer getIndex() {
        return index;
    }

    public void setIndex(Integer index) {
        this.index = index;
    }
}
