package com.group7.artshare.service

import com.group7.artshare.entity.RegisteredUser
import com.group7.artshare.repository.RegisteredUserRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.stereotype.Service
import org.springframework.web.server.ResponseStatusException
import java.util.*

@Service
class ProfileService(
    private val registeredUserService: RegisteredUserService,
    private val jwtService: JwtService
    ) {

    @Autowired
    lateinit var registeredUserRepository: RegisteredUserRepository

    fun getUserByUsernameOrToken(username: String?, authorizationHeader: String?): RegisteredUser {
        try {
            username?.let {
                return registeredUserService.findByUsername(it) ?: throw Exception("User not found")
            } ?: run {
                authorizationHeader?.let {
                    val user = jwtService.getUserFromAuthorizationHeader(authorizationHeader)
                        ?: throw Exception("Invalid token")
                    val usernameFromToken = user.username ?: throw Exception("Username couldn't be found")
                    return registeredUserService.findByUsername(usernameFromToken) ?: throw Exception("User not found")
                } ?: throw Exception("Username and token are not provided")
            }
        } catch (e: Exception) {
            if (e.message == "Invalid token") {
                throw ResponseStatusException(HttpStatus.UNAUTHORIZED, e.message)
            } else {
                throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
            }
        }
    }

    fun followUser(username: String , user: RegisteredUser) : RegisteredUser {
        var followedUser : RegisteredUser? = registeredUserRepository.findByAccountInfo_Username(username)
        if(Objects.nonNull(followedUser)) {
            user.following.add(followedUser!!)
            return registeredUserRepository.save(user)
        }else
            throw ResponseStatusException(HttpStatus.BAD_REQUEST, "Could not find user with given username")
    }

}