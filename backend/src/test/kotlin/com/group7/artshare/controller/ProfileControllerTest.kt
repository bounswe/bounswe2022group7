package com.group7.artshare.controller

import com.group7.artshare.SettingDTO
import com.group7.artshare.entity.*
import com.group7.artshare.request.ArtItemRequest
import com.group7.artshare.service.ImageService
import com.group7.artshare.service.JwtService
import com.group7.artshare.service.ProfileService
import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith
import org.mockito.ArgumentMatchers
import org.mockito.InjectMocks
import org.mockito.Mock
import org.mockito.Mockito.`when`
import org.mockito.junit.jupiter.MockitoExtension
import org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.JwtRequestPostProcessor
import org.springframework.web.server.ResponseStatusException
import java.util.*


@ExtendWith(MockitoExtension::class)
internal class ProfileControllerTest {

    @InjectMocks
    lateinit var profileController: ProfileController

    @Mock
    lateinit var profileService: ProfileService

    @Mock
    lateinit var jwtService: JwtService

    @Test
    fun successfullyReturnsGenericProfile() {
        val accountInfo1 = AccountInfo("email@email.com", "janedoe", "31415926")
        val mockUser = RegisteredUser(accountInfo1, setOf())
        `when`(profileService.getUserByUsernameOrToken(mockUser.username, null)).thenReturn(mockUser)
        val response = mockUser.username?.let { profileController.getUserByUsername(it, null) }
        assert(response != null)
        if (response != null) {
            assert(response.accountInfo?.username == mockUser.username)
        }
    }

    @Test
    fun successfullyReturnsPrivateProfile() {
        val accountInfo1 = AccountInfo("email@email.com", "janedoe", "31415926")
        val mockUser = RegisteredUser(accountInfo1, setOf())
        `when`(profileService.getUserByUsernameOrToken(null, "authorizationHeader")).thenReturn(mockUser)
        val response = profileController.getUserByToken("authorizationHeader")
        assert(response.accountInfo?.username == mockUser.username)
    }

    @Test
    fun failsToGetSettingsIfNotHasAuthorization() {
        assertThrows(ResponseStatusException::class.java) { profileController.getSettingsForUser("someAuthorization") }
    }

    @Test
    fun successfullyGetSettings() {
        val accountInfo1 = AccountInfo("email@email.com", "janedoe", "31415926")
        val mockUser = RegisteredUser(accountInfo1, setOf())
        val mockSettingDTO = SettingDTO()
        mockSettingDTO.username = mockUser.username
        `when`(jwtService.getUserFromAuthorizationHeader("authorizationHeader")).thenReturn(mockUser)
        `when`(profileService.getSettings(mockUser)).thenReturn(mockSettingDTO)
        val response = profileController.getSettingsForUser("authorizationHeader")
        assert(response.username == mockUser.username)
    }

    @Test
    fun successfullySetSettings() {
        val accountInfo1 = AccountInfo("email@email.com", "janedoe", "31415926")
        val mockUser = RegisteredUser(accountInfo1, setOf())
        val mockSettingDTO = SettingDTO()
        mockSettingDTO.username = "newUsername"
        `when`(jwtService.getUserFromAuthorizationHeader("authorizationHeader")).thenReturn(mockUser)
        `when`(profileService.setSettings(mockUser, mockSettingDTO)).thenReturn(mockSettingDTO)
        val response = profileController.setSettingsForUser(mockSettingDTO, "authorizationHeader")
        assert(response.username == mockSettingDTO.username)
    }
}