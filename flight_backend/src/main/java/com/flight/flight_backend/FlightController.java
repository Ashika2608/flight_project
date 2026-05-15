package com.flight.flight_backend;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/bookings") // ✅ Flutter-ல 'api/bookings' கூப்பிடுறதுனால இங்கயும் அதையே மாத்தியிருக்கேன்
@CrossOrigin(origins = "*") // ✅ இதுதான் Flutter-ஐ உள்ள அனுமதிக்கும்
public class FlightController {

    @Autowired
    private BookingRepository repo;

    // ✅ எல்லா புக்கிங் விவரங்களையும் எடுக்க (Read All)
    @GetMapping
    public List<Booking> getAll() {
        return repo.findAll();
    }

    // ✅ புது புக்கிங் உருவாக்க (Create)
    @PostMapping
    public Booking create(@RequestBody Booking booking) {
        System.out.println("Booking received for: " + booking.getPassengerName());
        return repo.save(booking);
    }

    // ✅ ஒரு குறிப்பிட்ட புக்கிங்கை டெலீட் செய்ய (Delete)
    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        repo.deleteById(id);
    }
}