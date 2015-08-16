package com.next.nivell.alerts.model;


import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.UUID;

@Entity
@XmlRootElement
public class Alert implements Serializable {

    public static final String PLATFORM_DATE_FORMAT = "yyyy-MM-dd hh:mm:ss";

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 10)
    private String tankReference;

    @Column(nullable = false)
    private BigDecimal level;

    @Temporal(TemporalType.TIMESTAMP)
    private Date time;

    public Alert() { }


    public void setTankReference(String tankReference) {
        this.tankReference = tankReference;
    }

    public void setLevel(BigDecimal level) {
        this.level = level;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public static String getPlatformDateFormat() {
        return PLATFORM_DATE_FORMAT;
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


}
