package com.Softwaring.OdeProServer.exception;

public class NotFoundException extends RuntimeException {

    public NotFoundException(Class<?> entityClass, String fieldName, Object fieldValue) {
        super(String.format("%s not found for %s: %s", entityClass.getSimpleName(), fieldName, fieldValue));
    }

    public NotFoundException(Class<?> entityClass, String fieldName, Object fieldValue, Throwable cause) {
        super(String.format("%s not found for %s: %s", entityClass.getSimpleName(), fieldName, fieldValue), cause);
    }

    public NotFoundException(Class<?> entityClass, String fieldName, String message, Object fieldValue) {
        super(String.format("%s not found for %s %s %s", entityClass.getSimpleName(), fieldName, message, fieldValue));
    }
}