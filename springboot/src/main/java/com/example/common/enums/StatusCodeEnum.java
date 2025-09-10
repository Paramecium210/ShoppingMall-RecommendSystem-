package com.example.common.enums;

public enum StatusCodeEnum {
    CHECKING("CHECKING"),
    CHECK_OK("CHECK_OK"),
    CHECK_NO("CHECK_NO")

    ;

    public String status;

    StatusCodeEnum(String status) {
        this.status = status;
    }
}
