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

    @Test
    fun participateAnEvent() {
        val authorizationHeader = "Bearer token"
        val user = RegisteredUser(AccountInfo("email","username", "password"),setOf(Authority("ARTIST")))
        whenever(jwtService.getUserFromAuthorizationHeader(authorizationHeader)).thenReturn(user)
        val event = PhysicalExhibition()
        Mockito.`when`(eventService.participateAnEvent(event.id,user)).then {
            event.participants.add(user)
            event
        }
        val result = eventController.participateAnEvent(event.id,authorizationHeader)
        assertEquals(1, result.participantUsernames.size)
        assertEquals(user.username, result.participantUsernames[0])
    }

    @Test
    fun unparticipateAnEvent() {
        val authorizationHeader = "Bearer token"
        val user = RegisteredUser(AccountInfo("email","username", "password"),setOf(Authority("ARTIST")))
        whenever(jwtService.getUserFromAuthorizationHeader(authorizationHeader)).thenReturn(user)
        val event = PhysicalExhibition()
        event.participants.add(user)
        Mockito.`when`(eventService.participateAnEvent(event.id,user)).then {
            event.participants.remove(user)
            event
        }
        val result = eventController.participateAnEvent(event.id,authorizationHeader)
        assertEquals(0, result.participantUsernames.size)
    }
}