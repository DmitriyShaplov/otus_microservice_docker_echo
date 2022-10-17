package ru.shaplov.dockerecho.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import ru.shaplov.dockerecho.model.HealthResponse;

@RestController
public class HealthController {

    @GetMapping("/health")
    public HealthResponse echo() {
        return new HealthResponse("OK");
    }
}
