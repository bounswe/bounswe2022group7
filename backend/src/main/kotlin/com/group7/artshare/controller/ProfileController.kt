package com.group7.artshare.controller

import com.group7.artshare.DTO.RegisteredUserDTO
import com.group7.artshare.SettingDTO
import com.group7.artshare.entity.RegisteredUser
import com.group7.artshare.service.JwtService
import com.group7.artshare.service.ProfileService
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.*
import org.springframework.web.server.ResponseStatusException

@RestController
@CrossOrigin(origins = ["*"], allowedHeaders = ["*"])
@RequestMapping("profile")
class ProfileController(
    private val profileService: ProfileService,
    private val jwtService: JwtService
) {

    @GetMapping("{username}")
    fun getUserByUsername(
        @PathVariable(value = "username") username: String,
        @RequestHeader(value = "Authorization", required = false) authorizationHeader: String?
    ): RegisteredUserDTO {
        return profileService.getUserByUsernameOrToken(username, authorizationHeader).mapToDTO()
    }

    @GetMapping()
    fun getUserByToken(
        @RequestHeader(value = "Authorization", required = true) authorizationHeader: String
    ): RegisteredUserDTO {
        return profileService.getUserByUsernameOrToken(null, authorizationHeader).mapToDTO()
    }

    @GetMapping("settings")
    fun getSettingsForUser(
        @RequestHeader(
            value = "Authorization",
            required = true
        ) authorizationHeader: String
    ) : SettingDTO {
        try {
            authorizationHeader.let {
                val user =
                    jwtService.getUserFromAuthorizationHeader(authorizationHeader) ?: throw Exception("Invalid token")
                return profileService.getSettings(user)
            }
        } catch (e: Exception) {
            if (e.message == "Invalid token") {
                throw ResponseStatusException(HttpStatus.UNAUTHORIZED, e.message)
            } else {
                throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
            }
        }
    }
    
    @PostMapping(
        value = ["settings"],
        consumes = ["application/json;charset=UTF-8"],
        produces = ["application/json;charset=UTF-8"]
    )
    fun setSettingsForUser(
        @RequestBody setting : SettingDTO,
        @RequestHeader(
            value = "Authorization",
            required = true
        ) authorizationHeader: String
    ) : SettingDTO {
        try {
            authorizationHeader.let {
                val user =
                    jwtService.getUserFromAuthorizationHeader(authorizationHeader) ?: throw Exception("Invalid token")
                return profileService.setSettings(user, setting)
            }
        } catch (e: Exception) {
            if (e.message == "Invalid token") {
                throw ResponseStatusException(HttpStatus.UNAUTHORIZED, e.message)
            } else {
                throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
            }
        }
    }

}