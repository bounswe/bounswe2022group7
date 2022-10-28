package com.group7.artshare.request

import lombok.Data
import lombok.Getter
import lombok.RequiredArgsConstructor
import javax.validation.constraints.NotEmpty


@Data
class SignupRequest {

    @NotEmpty
    private val username: String? = null

    @NotEmpty
    private val password: String? = null

    @NotEmpty
    private val userType: String?= null

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