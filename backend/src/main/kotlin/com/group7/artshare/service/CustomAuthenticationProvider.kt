package com.group7.artshare.service

import com.group7.artshare.repository.RegisteredUserRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.security.authentication.AuthenticationProvider
import org.springframework.security.authentication.BadCredentialsException
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.Authentication
import org.springframework.security.core.AuthenticationException
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.security.crypto.password.PasswordEncoder
import org.springframework.stereotype.Service

// THIS CODE IS TAKEN FROM https://github.com/fatihdogmus/yte-intern-spring-security/tree/intern-2021-1-jwt
// LITTLE OR NO MODIFICATIONS HAVE BEEN MADE TO THE CODE
@Service
class CustomAuthenticationProvider @Autowired constructor(
    registeredUserRepository: RegisteredUserRepository,
    passwordEncoder: PasswordEncoder,
    registeredUserService: RegisteredUserService
) : AuthenticationProvider {
    private val registeredUserRepository: RegisteredUserRepository
    private val passwordEncoder: PasswordEncoder
    private val registeredUserService: RegisteredUserService

    init {
        this.registeredUserRepository = registeredUserRepository
        this.passwordEncoder = passwordEncoder
        this.registeredUserService = registeredUserService
    }

    @Throws(AuthenticationException::class)
    override fun authenticate(authentication: Authentication): Authentication {
        val email = authentication.principal as String
        val password = authentication.credentials as String
        val userDetails: UserDetails = registeredUserService.findByEmail(email)
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