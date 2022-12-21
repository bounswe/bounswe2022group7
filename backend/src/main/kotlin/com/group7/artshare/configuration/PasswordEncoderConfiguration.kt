package com.group7.artshare.configuration

import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder
import org.springframework.security.crypto.password.PasswordEncoder

// THIS CODE IS TAKEN FROM https://github.com/fatihdogmus/yte-intern-spring-security/tree/intern-2021-1-jwt
// LITTLE OR NO MODIFICATIONS HAVE BEEN MADE TO THE CODE
@Configuration
class PasswordEncoderConfiguration {
    @Bean
    fun passwordEncoder(): PasswordEncoder {
        return BCryptPasswordEncoder()
    }
}