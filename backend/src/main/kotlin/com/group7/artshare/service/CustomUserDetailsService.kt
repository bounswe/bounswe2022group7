package com.group7.artshare.service

import com.group7.artshare.repository.CustomUserRepository
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.security.core.userdetails.UserDetailsService
import org.springframework.security.core.userdetails.UsernameNotFoundException
import org.springframework.stereotype.Service


@Service
class CustomUserDetailsService(customUserRepository: CustomUserRepository) : UserDetailsService {
    private val customUserRepository: CustomUserRepository

    init {
        this.customUserRepository = customUserRepository
    }

    @Throws(UsernameNotFoundException::class)
    override fun loadUserByUsername(username: String): UserDetails? {
        return customUserRepository.findByUsername(username)
            ?.orElseThrow { UsernameNotFoundException("User Not Found!") }
    }
}