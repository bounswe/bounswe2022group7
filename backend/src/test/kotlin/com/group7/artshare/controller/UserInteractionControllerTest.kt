package com.group7.artshare.controller

import com.group7.artshare.entity.*
import com.group7.artshare.service.JwtService
import com.group7.artshare.service.ProfileService
import com.group7.artshare.service.SearchService
import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith
import org.mockito.InjectMocks
import org.mockito.Mock
import org.mockito.Mockito.anyString
import org.mockito.Mockito.`when`
import org.mockito.junit.jupiter.MockitoExtension
import org.springframework.http.HttpStatus
import org.springframework.web.server.ResponseStatusException
import java.util.*


@ExtendWith(MockitoExtension::class)
internal class UserInteractionControllerTest {

    @InjectMocks
    lateinit var userInteractionController: UserInteractionController

    @Mock
    lateinit var profileService: ProfileService

    @Mock
    lateinit var jwtService: JwtService

    @Mock
    lateinit var searchService: SearchService

    @Test
    fun successfullyFollowsUser() {
        val accountInfo1 = AccountInfo("email@email.com", "janedoe", "31415926")
        val mockUser = RegisteredUser(accountInfo1, setOf())
        `when`(profileService.followUser("username", mockUser)).thenReturn(HttpStatus.ACCEPTED)
        `when`(jwtService.getUserFromAuthorizationHeader("authorizationHeader")).thenReturn(mockUser)
        val response = userInteractionController.followUser("username", "authorizationHeader")
        assert(response == Unit)
    }

    @Test
    fun failsIfFollowItself() {
        val accountInfo1 = AccountInfo("email@email.com", "janedoe", "31415926")
        val mockUser = RegisteredUser(accountInfo1, setOf())
        `when`(jwtService.getUserFromAuthorizationHeader("authorizationHeader")).thenReturn(mockUser)
        assertThrows(ResponseStatusException::class.java) {
            userInteractionController.followUser(
                "janedoe",
                "someAuthorization"
            )
        }
    }

    @Test
    fun failsIfCouldNotFindFollowedUser() {
        val accountInfo1 = AccountInfo("email@email.com", "janedoe", "31415926")
        val mockUser = RegisteredUser(accountInfo1, setOf())
        `when`(jwtService.getUserFromAuthorizationHeader("authorizationHeader")).thenReturn(mockUser)
        assertThrows(ResponseStatusException::class.java) {
            userInteractionController.followUser(
                anyString(),
                "someAuthorization"
            )
        }
    }

    @Test
    fun failsToFollowIfNotHasAuthorization() {
        assertThrows(ResponseStatusException::class.java) {
            userInteractionController.followUser(
                anyString(),
                "someAuthorization"
            )
        }
    }

}