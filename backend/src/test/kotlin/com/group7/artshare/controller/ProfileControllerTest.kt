package com.group7.artshare.controller

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
            assert(response.username == mockUser.username)
        }
    }

//    @Test
//    fun failsToGetIfInvalidToken() {
//       // val accountInfo1 = AccountInfo("email@email.com", "janedoe", "31415926")
//       // val mockUser = RegisteredUser(accountInfo1, setOf())
//        assertThrows(ResponseStatusException::class.java) { profileController.getUserByToken("authorization") }
//
//
//        `when`(profileService.getUserByUsernameOrToken(null, "Some Authorization")).thenReturn(mockUser)
//        val response = mockUser.username?.let { profileController.getUserByUsername(it, null) }
//        assert(response != null)
//        if (response != null) {
//            assert(response.username == mockUser.username)
//        }
    }

//    @Test
//    fun failsToDeleteIfNotHasAuthorization() {
//        assertThrows(ResponseStatusException::class.java) { artItemController.delete(ArgumentMatchers.anyLong(), "someAuthorization") }
//
//    }

//    @Test
//    fun successfullyPostsArtItem() {
//        val mockArtItemInfo = ArtItemInfo()
//        val mockArtItemRequest = ArtItemRequest(mockArtItemInfo, 1.0)
//        val accountInfo1 = AccountInfo("email@email.com", "janedoe", "31415926")
//        val mockArtist= Artist(accountInfo1, setOf())
//        var mockArtItem = ArtItem()
//        mockArtItem.artItemInfo = mockArtItemInfo
//        mockArtItem.lastPrice = mockArtItemRequest.lastPrice!!
//        `when`(artItemService.createArtItem(mockArtItemRequest, mockArtist)).thenReturn(mockArtItem)
//        `when`(jwtService.getUserFromAuthorizationHeader("authorizationHeader")).thenReturn(mockArtist)
//        val response = artItemController.create(mockArtItemRequest, "authorizationHeader")
//        assert(response.lastPrice == mockArtItemRequest.lastPrice)
//    }
//
//    @Test
//    fun successfullyDeletesComment() {
//        val accountInfo1 = AccountInfo("email@email.com", "janedoe", "31415926")
//        val mockUser = RegisteredUser(accountInfo1, setOf())
//        `when`(jwtService.getUserFromAuthorizationHeader("authorizationHeader")).thenReturn(mockUser)
//        val response = artItemController.delete(3,"authorizationHeader")
//        assert(response == Unit)
//    }
}