package com.group7.artshare.service

import com.group7.artshare.entity.RegisteredUser
import com.group7.artshare.repository.AccountInfoRepository
import com.group7.artshare.repository.RegisteredUserRepository
import org.springframework.stereotype.Service

@Service
class RegisteredUserService(
    private val registeredUserRepository: RegisteredUserRepository,
    private val accountInfoRepository: AccountInfoRepository
) {
    fun findByUsername(username: String):RegisteredUser? = accountInfoRepository.findByUsername(username)?.registeredUser
}