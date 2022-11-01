package com.group7.artshare.request

import lombok.Data
import lombok.Getter
import lombok.RequiredArgsConstructor
import javax.validation.constraints.NotEmpty


@Data
@RequiredArgsConstructor
class LoginRequest {

    @NotEmpty
    private val email: String? = null

    @NotEmpty
    private val password: String? = null

    fun getEmail(): String? {
        return email
    }

    fun getPassword(): String? {
        return password
    }
}