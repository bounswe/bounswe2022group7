package com.group7.artshare.service

import com.group7.artshare.entity.AccountInfo
import com.group7.artshare.entity.Artist
import com.group7.artshare.entity.Authority
import com.group7.artshare.entity.RegisteredUser
import com.group7.artshare.repository.ArtistRepository
import com.group7.artshare.repository.RegisteredUserRepository
import com.group7.artshare.request.SignupRequest
import com.group7.artshare.utils.JwtUtil
import org.springframework.http.HttpStatus
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.security.crypto.password.PasswordEncoder
import org.springframework.stereotype.Service
import org.springframework.web.server.ResponseStatusException

@Service
class SignupService(
    private val registeredUserRepository: RegisteredUserRepository,
    private val artistRepository: ArtistRepository,
    private val registeredUserService: RegisteredUserService,
    private val passwordEncoder: PasswordEncoder,
    private val jwtService: JwtService
) {
    fun signup(signupRequest: SignupRequest): TokenResponse {
        try {
            val email = signupRequest.getEmail() ?: throw Exception("Email is not specified")
            val password = signupRequest.getPassword() ?: throw Exception("Password is not specified")
            val username = signupRequest.getUsername() ?: throw Exception("Username is not specified")
            val userType = signupRequest.getUserType() ?: throw Exception("User type is not specified")

            val encryptedPassword = passwordEncoder.encode(password)

            registeredUserService.findByUsername(username)?.let { throw Exception("Username is already taken") }
            registeredUserService.findByEmail(email)?.let { throw Exception("Email is already taken") }

            val accountInfo = AccountInfo(email, username, encryptedPassword)
            val user : RegisteredUser
            when (val userTypeUpperCase = userType.uppercase()) {
                "ARTIST" -> {
                    user = Artist(accountInfo, setOf(Authority(userTypeUpperCase)))
                    artistRepository.saveAndFlush(user)
                }
                "REGULAR USER" -> {
                    user = RegisteredUser(accountInfo, setOf(Authority(userTypeUpperCase)))
                    registeredUserRepository.saveAndFlush(user)
                }
                else -> throw Exception("Invalid user type")
            }
            val authentication = UsernamePasswordAuthenticationToken(user as UserDetails, null, user.authorities)
            val token = JwtUtil.generateToken(authentication, jwtService.getSecretKey())
            return TokenResponse(token)
        } catch (e: Exception) {
            throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
        }
    }


}