package com.group7.artshare.controller

import com.group7.artshare.entity.*
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