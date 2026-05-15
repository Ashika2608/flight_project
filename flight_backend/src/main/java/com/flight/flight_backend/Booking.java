package com.flight.flight_backend;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class Booking {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String passengerName;
    private String source;
    private String destination;
    private String seatType;
    private Double price;

    // Default Constructor (கண்டிப்பா இருக்கணும்)
    public Booking() {}

    // Getters and Setters (இதை வச்சு தான் டேட்டா சேமிக்க முடியும்)
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getPassengerName() { return passengerName; }
    public void setPassengerName(String passengerName) { this.passengerName = passengerName; }

    public String getSource() { return source; }
    public void setSource(String source) { this.source = source; }

    public String getDestination() { return destination; }
    public void setDestination(String destination) { this.destination = destination; }

    public String getSeatType() { return seatType; }
    public void setSeatType(String seatType) { this.seatType = seatType; }

    public Double getPrice() { return price; }
    public void setPrice(Double price) { this.price = price; }
}