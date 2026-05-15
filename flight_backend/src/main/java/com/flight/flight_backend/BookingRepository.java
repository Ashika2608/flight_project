package com.flight.flight_backend;

import org.springframework.data.jpa.repository.JpaRepository;

public interface BookingRepository extends JpaRepository<Booking, Long> {
    // இது தானாகவே எல்லா CRUD methods-யும் கொண்டு வரும்
}