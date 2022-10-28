package com.group7.artshare.service

import com.group7.artshare.request.LoginRequest
import com.group7.artshare.utils.JwtUtil.generateToken
import org.springframework.beans.factory.annotation.Value
import org.springframework.security.authentication.AuthenticationManager
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.AuthenticationException
import org.springframework.stereotype.Service


@Service
class LoginService(private val authenticationManager: AuthenticationManager) {
    @Value("\${security.jwt.secret-key}")
    private val secretKey: String? = null
    fun login(loginRequest: LoginRequest): String? {
        val token = UsernamePasswordAuthenticationToken(loginRequest.getEmail(), loginRequest.getPassword())
        try {
            val authenticatedToken = authenticationManager.authenticate(token)
            return generateToken(authenticatedToken, secretKey!!)
        } catch (ex: AuthenticationException) {
        }
        return null
    }
}