package com.group7.artshare.controller

import com.group7.artshare.entity.*
import com.group7.artshare.repository.ImageRepository
import com.group7.artshare.request.ArtItemRequest
import com.group7.artshare.service.ArtItemService
import com.group7.artshare.service.JwtService
import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith
import org.mockito.ArgumentMatchers.anyLong
import org.mockito.InjectMocks
import org.mockito.Mock
import org.mockito.Mockito
import org.mockito.Mockito.`when`
import org.mockito.junit.jupiter.MockitoExtension
import org.mockito.kotlin.whenever
import org.springframework.web.server.ResponseStatusException


@ExtendWith(MockitoExtension::class)
internal class ArtItemControllerTest {

    @InjectMocks
    lateinit var artItemController: ArtItemController

    @Mock
    lateinit var imageRepository: ImageRepository

    @Mock
    lateinit var artItemService: ArtItemService

    @Mock
    lateinit var jwtService: JwtService

    @Test
    fun failsToCreateIfNotHasAuthorization() {
        val mockArtItemInfo = ArtItemInfo()
        val mockArtItemRequest = ArtItemRequest(mockArtItemInfo, 1.0)
        assertThrows(ResponseStatusException::class.java) { artItemController.create(mockArtItemRequest, "someAuthorization") }
    }

    @Test
    fun failsToDeleteIfNotHasAuthorization() {
        assertThrows(ResponseStatusException::class.java) { artItemController.delete(anyLong(), "someAuthorization") }

    }

    @Test
    fun successfullyPostsArtItem() {
        val mockArtItemInfo = ArtItemInfo()
        val mockArtItemRequest = ArtItemRequest(mockArtItemInfo, 1.0)
        val accountInfo1 = AccountInfo("email@email.com", "janedoe", "31415926")
        val mockArtist= Artist(accountInfo1, setOf())
        var mockArtItem = ArtItem()
        mockArtItem.artItemInfo = mockArtItemInfo
        mockArtItem.lastPrice = mockArtItemRequest.lastPrice!!
        `when`(artItemService.createArtItem(mockArtItemRequest, mockArtist)).thenReturn(mockArtItem)
        `when`(jwtService.getUserFromAuthorizationHeader("authorizationHeader")).thenReturn(mockArtist)
        val response = artItemController.create(mockArtItemRequest, "authorizationHeader")
        assert(response.lastPrice == mockArtItemRequest.lastPrice)
    }

    @Test
    fun successfullyDeletesComment() {
        val accountInfo1 = AccountInfo("email@email.com", "janedoe", "31415926")
        val mockUser = RegisteredUser(accountInfo1, setOf())
        `when`(jwtService.getUserFromAuthorizationHeader("authorizationHeader")).thenReturn(mockUser)
        val response = artItemController.delete(3,"authorizationHeader")
        assert(response == Unit)
    }

    @Test
    fun bookmarkAnArtItem() {
        val authorizationHeader = "Bearer token"
        val user = RegisteredUser(AccountInfo("email","username", "password"),setOf(Authority("ARTIST")))
        whenever(jwtService.getUserFromAuthorizationHeader(authorizationHeader)).thenReturn(user)
        val artItem = ArtItem()
        whenever(artItemService.bookmarkAnArtItem(artItem.id,user)).then {
            artItem.bookmarkedBy.add(user)
            return@then artItem
        }
        val result = artItemController.bookmarkAnArtItem(artItem.id,authorizationHeader)
        assertEquals(1, result.bookmarkedByUsernames.size)
        assertEquals(user.username, result.bookmarkedByUsernames[0])
    }

    @Test
    fun undoBookmarkAnArtItem() {
        val authorizationHeader = "Bearer token"
        val user = RegisteredUser(AccountInfo("email","username", "password"),setOf(Authority("ARTIST")))
        whenever(jwtService.getUserFromAuthorizationHeader(authorizationHeader)).thenReturn(user)
        val artItem = ArtItem()
        artItem.bookmarkedBy.add(user)
        whenever(artItemService.bookmarkAnArtItem(artItem.id,user)).then {
            artItem.bookmarkedBy.remove(user)
            return@then artItem
        }
        val result = artItemController.bookmarkAnArtItem(artItem.id,authorizationHeader)
        assertEquals(0, result.bookmarkedByUsernames.size)
    }

    @Test
    fun likeAnArtItem() {
        val authorizationHeader = "Bearer token"
        val user = RegisteredUser(AccountInfo("email","username", "password"),setOf(Authority("ARTIST")))
        whenever(jwtService.getUserFromAuthorizationHeader(authorizationHeader)).thenReturn(user)
        val artItem = ArtItem()
        whenever(artItemService.likeAnArtItem(artItem.id,user)).then {
            artItem.likedBy.add(user)
            return@then artItem
        }
        val result = artItemController.likeAnArtItem(artItem.id,authorizationHeader)
        assertEquals(1, result.likedByUsernames.size)
        assertEquals(user.username, result.likedByUsernames[0])
    }

    @Test
    fun undoLikeAnArtItem() {
        val authorizationHeader = "Bearer token"
        val user = RegisteredUser(AccountInfo("email","username", "password"),setOf(Authority("ARTIST")))
        whenever(jwtService.getUserFromAuthorizationHeader(authorizationHeader)).thenReturn(user)
        val artItem = ArtItem()
        artItem.likedBy.add(user)
        whenever(artItemService.likeAnArtItem(artItem.id,user)).then {
            artItem.likedBy.remove(user)
            return@then artItem
        }
        val result = artItemController.likeAnArtItem(artItem.id,authorizationHeader)
        assertEquals(0, result.likedByUsernames.size)
    }
}