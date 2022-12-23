package com.group7.artshare.service

import com.group7.artshare.DTO.SettingDTO
import com.group7.artshare.entity.RegisteredUser
import com.group7.artshare.repository.RegisteredUserRepository
import com.group7.artshare.repository.ImageRepository
import org.springframework.http.HttpStatus
import org.springframework.stereotype.Service
import org.springframework.web.server.ResponseStatusException
import java.util.*

@Service
class ProfileService(
    private val registeredUserService: RegisteredUserService,
    private val jwtService: JwtService,
    private val registeredUserRepository: RegisteredUserRepository,
    private val imageRepository: ImageRepository
) {
    
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

    fun followUser(username: String , user: RegisteredUser) : HttpStatus {
        var followedUser : RegisteredUser? = registeredUserService.findByUsername(username)
        if(Objects.nonNull(followedUser) && (followedUser?.id != user?.id)) {
            user.following.add(followedUser!!)
            followedUser.followedBy.add(user)
            registeredUserRepository.save(followedUser)
            registeredUserRepository.save(user)
            return HttpStatus.ACCEPTED
        }else if(followedUser?.id != user?.id)
            throw ResponseStatusException(HttpStatus.BAD_REQUEST, "Could not find user with given username")
        else
            throw ResponseStatusException(HttpStatus.BAD_REQUEST, "User cannot follow itself")
    }
    
    fun getSettings(user: RegisteredUser) : SettingDTO {
        var settings  = SettingDTO()
        settings.email = user.getEmail()
        settings.username = user.username
        settings.name = user.accountInfo?.name
        settings.surname = user.accountInfo?.surname
        settings.country = user.accountInfo?.country
        settings.dateOfBirth = user.accountInfo?.dateOfBirth
        if (Objects.nonNull(user.accountInfo?.profilePictureId) && imageRepository.existsById(user.accountInfo?.profilePictureId!!))
            settings.profilePictureId = user.accountInfo?.profilePictureId
        else if(Objects.nonNull(user.accountInfo?.profilePictureId))
            throw ResponseStatusException(HttpStatus.NOT_FOUND, "Id is not matched with any of the images in the database")
        return settings
    }


    fun setSettings(user: RegisteredUser, newSetting : SettingDTO) : SettingDTO {
        var optional = registeredUserRepository.findById(user.id)
        if(optional.isPresent){
            val userFromDB = optional.get()
            fillBlank(newSetting, userFromDB)
            return getSettings(registeredUserRepository.save(userFromDB))
        }else
            throw ResponseStatusException(HttpStatus.BAD_REQUEST, "No settings found for user")
    }

    fun fillBlank(setting : SettingDTO, userFromDB : RegisteredUser) {
        if (Objects.nonNull(setting.email))
            userFromDB.accountInfo?.email = setting.email.orEmpty()
        if (Objects.nonNull(setting.username))
            userFromDB.accountInfo?.username = setting.username.orEmpty()
        if (Objects.nonNull(setting.name))
            userFromDB.accountInfo?.name = setting.name.orEmpty()
        if (Objects.nonNull(setting.surname))
            userFromDB.accountInfo?.surname = setting.surname.orEmpty()
        if (Objects.nonNull(setting.country))
            userFromDB.accountInfo?.country = setting.country.orEmpty()
        if (Objects.nonNull(setting.dateOfBirth))
            userFromDB.accountInfo?.dateOfBirth = setting.dateOfBirth
        if (Objects.nonNull(setting.profilePictureId))
            userFromDB.accountInfo?.profilePictureId = setting.profilePictureId
    }
}