package com.group7.artshare.service

import com.group7.artshare.entity.AccountInfo
import com.group7.artshare.entity.Authority
import com.group7.artshare.entity.RegisteredUser
import com.group7.artshare.repository.RegisteredUserRepository
import com.group7.artshare.request.SignupRequest
import org.springframework.security.crypto.password.PasswordEncoder
import org.springframework.stereotype.Service

@Service
class SignupService(
    private val registeredUserRepository: RegisteredUserRepository,
    private val registeredUserService: RegisteredUserService,
    private val passwordEncoder: PasswordEncoder
) {
    fun signup(signupRequest: SignupRequest): Boolean {
        try {
            val userType = signupRequest.getUserType()
            val email = signupRequest.getEmail()
            val password = signupRequest.getPassword()
            val username = signupRequest.getUsername()
            if(userType == null || email == null || password == null || username == null) {
                return false
            }
            val encryptedPassword = passwordEncoder.encode(password)

            registeredUserService.findByUsername(username)?.let{return false}
            registeredUserService.findByEmail(email)?.let{return false}

            val accountInfo = AccountInfo(email, username, encryptedPassword)
            accountInfo.age = signupRequest.getAge()
            accountInfo.name = signupRequest.getName()
            accountInfo.surname = signupRequest.getSurname()
            accountInfo.country = signupRequest.getCountry()

            val user = RegisteredUser(accountInfo, setOf(Authority(userType)))
            registeredUserRepository.save(user)
            return true
        } catch (e: Exception) {
            return false
        }
    }


}