package com.lostandfound.service;

import com.lostandfound.model.User;
import com.lostandfound.repository.UserRepository;
import com.lostandfound.security.JwtUtil;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class AuthService {
    private final UserRepository userRepo;
    private final BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
    private final JwtUtil jwtUtil;

    public AuthService(UserRepository userRepo, JwtUtil jwtUtil) {
        this.userRepo = userRepo;
        this.jwtUtil = jwtUtil;
    }

    public String register(String psid, String email, String password, String name) {
        User user = new User();
        user.setPsid(psid);
        user.setEmail(email);
        user.setPassword(encoder.encode(password));
        user.setName(name);
        user.setIsAdmin(false);
        userRepo.save(user);
        return jwtUtil.generateToken(psid);
    }

    public String login(String psid, String password) {
        User user = userRepo.findByPsid(psid).orElseThrow();
        if (encoder.matches(password, user.getPassword())) {
            return jwtUtil.generateToken(psid);
        }
        throw new RuntimeException("Invalid credentials");
    }
}