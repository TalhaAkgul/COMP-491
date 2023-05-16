package com.Softwaring.OdeProServer.util;

import jakarta.persistence.Column;

import java.lang.reflect.Field;

public class EntityUtils {
    public static String getColumnName(Class<?> entityClass, String variableName) {
        try {
            Field field = entityClass.getDeclaredField(variableName);
            Column column = field.getAnnotation(Column.class);
            if (column != null) {
                return entityClass.getName() + " " + column.name();
            }
        } catch (NoSuchFieldException e) {
            e.printStackTrace();
        }
        return null;
    }
}