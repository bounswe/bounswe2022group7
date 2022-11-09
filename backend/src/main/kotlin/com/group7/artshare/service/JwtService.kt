package com.group7.artshare.service

import com.group7.artshare.entity.RegisteredUser
import com.group7.artshare.repository.AccountInfoRepository
import com.group7.artshare.repository.RegisteredUserRepository
import com.group7.artshare.utils.JwtUtil.extractEmail
import org.springframework.beans.factory.annotation.Value
import org.springframework.stereotype.Service

@Service
class JwtService(private val registeredUserService: RegisteredUserService) {
    @Value("\${security.jwt.secret-key}")
    private val secretKey: String? = null

    fun getSecretKey(): String {
        return secretKey!!
    }

    fun getTokenFromAuthorizationHeader(authorizationHeader: String): String {
        if(authorizationHeader.startsWith("Bearer")) {
            return authorizationHeader.substring(7)
        }else {
            throw Exception("Invalid token")
        }
    }

    fun getUserFromToken(jwtToken: String?): RegisteredUser? {
        val email = extractEmail(jwtToken, secretKey!!)
        return registeredUserService.findByEmail(email)
    }

    fun getUserFromAuthorizationHeader(authorizationHeader: String): RegisteredUser? {
        val jwtToken = getTokenFromAuthorizationHeader(authorizationHeader)
        return getUserFromToken(jwtToken)
    }
}