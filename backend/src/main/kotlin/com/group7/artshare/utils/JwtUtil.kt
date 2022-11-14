package com.group7.artshare.utils

import com.group7.artshare.entity.RegisteredUser
import io.jsonwebtoken.Jwts
import io.jsonwebtoken.security.Keys
import org.springframework.security.core.Authentication
import org.springframework.security.core.GrantedAuthority
import java.time.LocalDate
import java.time.ZoneId
import java.util.*

object JwtUtil {
    fun generateToken(user: Authentication, key: String): String {
        return Jwts.builder()
            .setSubject((user.principal as RegisteredUser).getEmail())
            .claim("authorities", getAuthorities(user))
            .setExpiration(expirationDate)
            .signWith(Keys.hmacShaKeyFor(key.toByteArray()))
            .compact()
    }

    private fun getAuthorities(user: Authentication): List<String> {
        return user.authorities
            .stream()
            .map { obj: GrantedAuthority -> obj.authority }
            .toList()
    }

    private val expirationDate: Date
        get() {
            val expirationTime = LocalDate.now()
                .plusDays(365)
                .atStartOfDay()
                .atZone(ZoneId.systemDefault())
                .toInstant()
            return Date.from(expirationTime)
        }

    fun extractEmail(jwtToken: String?, secretKey: String): String {
        val claims = Jwts.parserBuilder()
            .setSigningKey(Keys.hmacShaKeyFor(secretKey.toByteArray()))
            .build()
            .parseClaimsJws(jwtToken)
            .body
        return claims.subject
    }
}