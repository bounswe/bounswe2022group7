package com.group7.artshare.request

import lombok.Data
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

    @NotEmpty
    private val name: String?= null

    @NotEmpty
    private val surname: String?= null

    @NotEmpty
    private val age: Int?= null

    @NotEmpty
    private val country: String?= null

    fun getName(): String? {
        return name
    }

    fun getSurname(): String? {
        return surname
    }

    fun getAge(): Int? {
        return age
    }
    fun getCountry(): String? {
        return country
    }
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