package com.group7.artshare.service

import com.group7.artshare.entity.AccountInfo
import com.group7.artshare.entity.Authority
import com.group7.artshare.entity.RegisteredUser
import com.group7.artshare.repository.RegisteredUserRepository
import com.group7.artshare.request.SignupRequest
import org.springframework.stereotype.Service

@Service
class SignupService(private val registeredUserRepository: RegisteredUserRepository) {

    fun signup(signupRequest: SignupRequest): Boolean {
        try {
            val userType = signupRequest.getUserType()
            val username = signupRequest.getUsername()
            val password = signupRequest.getPassword()
            if(userType == null || username == null || password == null){
                return false
            }
            val accountInfo = AccountInfo(username, password)
            val user = RegisteredUser(accountInfo, setOf(Authority(userType)))
            registeredUserRepository.save(user)
            return true
        } catch (e: Exception) {
            return false
        }
    }


}