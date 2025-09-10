package com.example.common.enums;

public enum ResultCodeEnum {
    SUCCESS("200", "Success"),

    PARAM_ERROR("400", "Parameter exception"),
    TOKEN_INVALID_ERROR("401", "Invalid token"),
    TOKEN_CHECK_ERROR("401", "Token verification failed，please log in again"),
    PARAM_LOST_ERROR("4001", "Parameter missing"),

    SYSTEM_ERROR("500", "System exception"),
    USER_EXIST_ERROR("5001", "Username has already existed"),
    USER_NOT_LOGIN("5002", "User has not logged in"),
    USER_ACCOUNT_ERROR("5003", "Account or password is wrong"),
    USER_NOT_EXIST_ERROR("5004", "User does not exist"),
    PARAM_PASSWORD_ERROR("5005", "Password is wrong"),
    ALREADY_COLLECT_ERROR("5006", "You have already collected the goods"),
    ;

    public String code;
    public String msg;

    ResultCodeEnum(String code, String msg) {
        this.code = code;
        this.msg = msg;
    }
}
