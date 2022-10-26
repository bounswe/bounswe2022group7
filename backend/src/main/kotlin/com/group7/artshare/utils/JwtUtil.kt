package com.group7.artshare.utils

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
            .setSubject(user.name)
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
        private get() {
            val expirationTime = LocalDate.now()
                .plusDays(7)
                .atStartOfDay()
                .atZone(ZoneId.systemDefault())
                .toInstant()
            return Date.from(expirationTime)
        }

    fun extractUsername(jwtToken: String?, secretKey: String): String {
        val claims = Jwts.parserBuilder()
            .setSigningKey(Keys.hmacShaKeyFor(secretKey.toByteArray()))
            .build()
            .parseClaimsJws(jwtToken)
            .body
        return claims.subject
    }
}