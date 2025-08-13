package com.lostandfound.api;
import com.lostandfound.service.AuthService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/auth")
public class AuthController {
    private final AuthService authService;
    public AuthController(AuthService authService) { this.authService = authService; }

    @PostMapping("/register")
    public String register(@RequestParam String psid, @RequestParam String email, @RequestParam String password, @RequestParam String name) {
        return authService.register(psid, email, password, name);
    }

    @PostMapping("/login")
    public String login(@RequestParam String psid, @RequestParam String password) {
        return authService.login(psid, password);
    }
}