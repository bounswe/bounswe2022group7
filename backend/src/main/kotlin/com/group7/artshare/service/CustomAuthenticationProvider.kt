package com.group7.artshare.service

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.security.authentication.AuthenticationProvider
import org.springframework.security.authentication.BadCredentialsException
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.Authentication
import org.springframework.security.core.AuthenticationException
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.security.crypto.password.PasswordEncoder
import org.springframework.stereotype.Service


@Service
class CustomAuthenticationProvider @Autowired constructor(
    customUserDetailsService: CustomUserDetailsService,
    passwordEncoder: PasswordEncoder
) : AuthenticationProvider {
    private val customUserDetailsService: CustomUserDetailsService
    private val passwordEncoder: PasswordEncoder

    init {
        this.customUserDetailsService = customUserDetailsService
        this.passwordEncoder = passwordEncoder
    }

    @Throws(AuthenticationException::class)
    override fun authenticate(authentication: Authentication): Authentication {
        val username = authentication.principal as String
        val password = authentication.credentials as String
        val userDetails: UserDetails = customUserDetailsService.loadUserByUsername(username)
            ?: throw BadCredentialsException("User Not Found")
        if (!passwordEncoder.matches(password, userDetails.password)) {
            throw BadCredentialsException("Wrong Password")
        }
        return UsernamePasswordAuthenticationToken(userDetails, null, userDetails.authorities)
    }

    override fun supports(authentication: Class<*>?): Boolean {
        return UsernamePasswordAuthenticationToken::class.java.isAssignableFrom(authentication)
    }
}