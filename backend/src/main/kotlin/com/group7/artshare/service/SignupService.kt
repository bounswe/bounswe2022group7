package com.group7.artshare.service

import com.group7.artshare.entity.AccountInfo
import com.group7.artshare.entity.Authority
import com.group7.artshare.entity.RegisteredUser
import com.group7.artshare.repository.RegisteredUserRepository
import com.group7.artshare.request.SignupRequest
import org.springframework.http.HttpStatus
import org.springframework.security.crypto.password.PasswordEncoder
import org.springframework.stereotype.Service
import org.springframework.web.server.ResponseStatusException

@Service
class SignupService(
    private val registeredUserRepository: RegisteredUserRepository,
    private val registeredUserService: RegisteredUserService,
    private val passwordEncoder: PasswordEncoder
) {
    fun signup(signupRequest: SignupRequest) {
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
            registeredUserRepository.save(user)
        } catch (e: Exception) {
            throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
        }
    }


}