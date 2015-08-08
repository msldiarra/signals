package com.next.nivell.alerts.model;


import java.math.BigDecimal;
import java.util.Date;
import java.util.UUID;

public class Alert {

    public static final String PLATFORM_DATE_FORMAT = "yyyy-MM-dd hh:mm:ss";
    private UUID uid;
    private String tankReference;
    private BigDecimal level;
    private Date time;

    public Alert(UUID uid, String tankReference, BigDecimal level, Date time) {
        this.uid = uid;
        this.tankReference = tankReference;
        this.level = level;
        this.time = time;
    }

    public static String getPlatformDateFormat() {
        return PLATFORM_DATE_FORMAT;
    }

    public UUID getUid() {
        return uid;
    }

    public String getTankReference() {
        return tankReference;
    }

    public BigDecimal getLevel() {
        return level;
    }

    public Date getTime() {
        return time;
    }

    @Override
    public String toString() {
        return "Alert{" +
                "uid='" + uid + '\'' +
                ", tankReference='" + tankReference + '\'' +
                ", level=" + level +
                ", time=" + time +
                '}';
    }
}
