package com.Softwaring.OdeProServer.exception;

import java.util.List;

public class NotFoundException extends RuntimeException {

    public NotFoundException(Class<?> entityClass, String fieldName, Object fieldValue) {
        super(String.format("%s not found for %s: %s", entityClass.getSimpleName(), fieldName, fieldValue));
    }

    public NotFoundException(Class<?> entityClass, String fieldName, Object fieldValue, Throwable cause) {
        super(String.format("%s not found for %s: %s", entityClass.getSimpleName(), fieldName, fieldValue), cause);
    }
    public NotFoundException(String message) {
        super(message);
    }
}