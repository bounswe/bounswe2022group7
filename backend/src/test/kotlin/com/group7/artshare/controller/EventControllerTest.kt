package com.group7.artshare.controller

import com.group7.artshare.entity.AccountInfo
import com.group7.artshare.entity.Authority
import com.group7.artshare.entity.PhysicalExhibition
import com.group7.artshare.entity.RegisteredUser
import com.group7.artshare.service.EventService
import com.group7.artshare.service.JwtService
import org.junit.jupiter.api.Test

import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.extension.ExtendWith
import org.mockito.InjectMocks
import org.mockito.Mock
import org.mockito.Mockito
import org.mockito.junit.jupiter.MockitoExtension
import org.mockito.kotlin.whenever

@ExtendWith(MockitoExtension::class)
internal class EventControllerTest {

    @InjectMocks
    lateinit var eventController: EventController

    @Mock
    lateinit var eventService: EventService

    @Mock
    lateinit var jwtService: JwtService

    @Test
    fun bookmarkAnEvent() {
        val authorizationHeader = "Bearer token"
        val user = RegisteredUser(AccountInfo("email","username", "password"),setOf(Authority("ARTIST")))
        whenever(jwtService.getUserFromAuthorizationHeader(authorizationHeader)).thenReturn(user)
        val event = PhysicalExhibition()
        Mockito.`when`(eventService.bookmarkAnEvent(event.id,user)).then {
            event.bookmarkedBy.add(user)
            event
        }
        val result = eventController.bookmarkAnEvent(event.id,authorizationHeader)
        assertEquals(1, result.bookmarkedByUsernames.size)
        assertEquals(user.username, result.bookmarkedByUsernames[0])
    }

    @Test
    fun undoBookmarkAnEvent() {
        val authorizationHeader = "Bearer token"
        val user = RegisteredUser(AccountInfo("email","username", "password"),setOf(Authority("ARTIST")))
        whenever(jwtService.getUserFromAuthorizationHeader(authorizationHeader)).thenReturn(user)
        val event = PhysicalExhibition()
        event.bookmarkedBy.add(user)
        Mockito.`when`(eventService.bookmarkAnEvent(event.id,user)).then {
            event.bookmarkedBy.remove(user)
            event
        }
        val result = eventController.bookmarkAnEvent(event.id,authorizationHeader)
        assertEquals(0, result.bookmarkedByUsernames.size)
    }


}