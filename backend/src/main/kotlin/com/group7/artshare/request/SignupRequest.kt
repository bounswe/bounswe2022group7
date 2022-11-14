package com.group7.artshare.request

import lombok.Data
import java.util.*
import javax.validation.constraints.NotEmpty


@Data
class SignupRequest {

    @NotEmpty
    private val email: String? = null

    @NotEmpty
    private val username: String? = null

    @NotEmpty
    private val password: String? = null

    @NotEmpty
    private val userType: String?= null
    fun getEmail(): String? {
        return email
    }
    fun getUserType(): String? {
        return userType
    }
    fun getUsername(): String? {
        return username
    }

    fun getPassword(): String? {
        return password
    }
}