package com.group7.artshare.service

import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.module.kotlin.jacksonObjectMapper
import com.fasterxml.jackson.module.kotlin.jsonMapper
import com.group7.artshare.entity.AccountInfo
import com.group7.artshare.entity.Authority
import com.group7.artshare.entity.RegisteredUser
import com.group7.artshare.repository.RegisteredUserRepository
import com.group7.artshare.request.LoginRequest
import com.group7.artshare.request.SignupRequest
import com.group7.artshare.utils.JwtUtil
import org.springframework.http.HttpStatus
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.security.crypto.password.PasswordEncoder
import org.springframework.stereotype.Service
import org.springframework.web.server.ResponseStatusException
import javax.persistence.EntityManager
import javax.persistence.EntityManagerFactory

@Service
class SignupService(
    private val registeredUserRepository: RegisteredUserRepository,
    private val registeredUserService: RegisteredUserService,
    private val passwordEncoder: PasswordEncoder,
    private val jwtService: JwtService
) {
    fun signup(signupRequest: SignupRequest): TokenResponse {
        try {
            val email = signupRequest.getEmail() ?: throw Exception("Email is not specified")
            val password = signupRequest.getPassword() ?: throw Exception("Password is not specified")
            val username = signupRequest.getUsername() ?: throw Exception("Username is not specified")
            val userType = signupRequest.getUserType() ?: throw Exception("User type is not specified")

            val encryptedPassword = passwordEncoder.encode(password)

            registeredUserService.findByUsername(username)?.let { throw Exception("Username is already taken") }
            registeredUserService.findByEmail(email)?.let { throw Exception("Email is already taken") }

            val accountInfo = AccountInfo(email, username, encryptedPassword)
            val user = RegisteredUser(accountInfo, setOf(Authority(userType)))
            registeredUserRepository.saveAndFlush(user)
            val authentication = UsernamePasswordAuthenticationToken(user as UserDetails, null, user.authorities)
            val token = JwtUtil.generateToken(authentication, jwtService.getSecretKey())
            return TokenResponse(token)
        } catch (e: Exception) {
            throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
        }
    }


}