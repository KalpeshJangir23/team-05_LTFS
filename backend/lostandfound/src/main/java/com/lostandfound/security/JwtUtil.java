package com.lostandfound.security;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.nio.charset.StandardCharsets;
import java.security.Key;
import java.util.Date;

@Component
public class JwtUtil {

    @Value("${app.jwt.secret}")
    private String secret; // can be raw text or Base64; prefer a Base64-encoded 32+ byte value

    @Value("${app.jwt.expiration}")
    private long expiration;

    private Key getSigningKey() {
        // If you store a Base64 string: use Decoders.BASE64.decode(secret)
        // If you store raw text, convert bytes directly:
        byte[] keyBytes = secret.getBytes(StandardCharsets.UTF_8);
        return Keys.hmacShaKeyFor(keyBytes);
    }

    public String generateToken(String psid) {
        return Jwts.builder()
                .setSubject(psid)
                .setExpiration(new Date(System.currentTimeMillis() + expiration))
                .signWith(getSigningKey(), SignatureAlgorithm.HS256)
                .compact();
    }
}
