package com.Softwaring.OdeProServer.exception;

public class NotFoundException extends RuntimeException {

    public NotFoundException(Class<?> entityClass, Object entityId) {
        super(String.format("%s not found for id: %s", entityClass.getSimpleName(), entityId));
    }

    public NotFoundException(Class<?> entityClass, Object entityId, Throwable cause) {
        super(String.format("%s not found for id: %s", entityClass.getSimpleName(), entityId), cause);
    }
}