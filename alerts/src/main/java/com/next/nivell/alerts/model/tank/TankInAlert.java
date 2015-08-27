package com.next.nivell.alerts.model.tank;


import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;
import java.math.BigDecimal;

@Entity
@XmlRootElement
public class TankInAlert {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String tank;

    @Column(nullable = false)
    private String customer;

    @Column(nullable = false)
    private String station;

    @Column(nullable = false)
    private String liquidType;

    @Column(nullable = false)
    private BigDecimal level;

    @Temporal(TemporalType.TIMESTAMP)
    private BigDecimal measureTime;


    public String getTank() {
        return tank;
    }

    public void setTank(String tank) {
        this.tank = tank;
    }

    public String getCustomer() {
        return customer;
    }

    public void setCustomer(String customer) {
        this.customer = customer;
    }

    public String getStation() {
        return station;
    }

    public void setStation(String station) {
        this.station = station;
    }

    public String getLiquidType() {
        return liquidType;
    }

    public void setLiquidType(String liquidType) {
        this.liquidType = liquidType;
    }

    public BigDecimal getLevel() {
        return level;
    }

    public void setLevel(BigDecimal level) {
        this.level = level;
    }

    public BigDecimal getMeasureTime() {
        return measureTime;
    }

    public void setMeasureTime(BigDecimal measureTime) {
        this.measureTime = measureTime;
    }
}
