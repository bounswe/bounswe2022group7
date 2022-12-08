package com.group7.artshare.controller

import com.group7.artshare.entity.AccountInfo
import com.group7.artshare.entity.Authority
import com.group7.artshare.entity.RegisteredUser
import com.group7.artshare.request.VoteRequest
import com.group7.artshare.service.DiscussionPostService
import com.group7.artshare.service.JwtService
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test

import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.extension.ExtendWith
import org.mockito.InjectMocks
import org.mockito.Mock
import org.mockito.junit.jupiter.MockitoExtension
import org.mockito.kotlin.any
import org.mockito.kotlin.eq
import org.mockito.kotlin.whenever
import org.springframework.web.server.ResponseStatusException

@ExtendWith(MockitoExtension::class)
internal class DiscussionPostControllerTest {

    @InjectMocks
    lateinit var discussionPostController: DiscussionPostController

    @Mock
    lateinit var discussionPostService: DiscussionPostService

    @Mock
    lateinit var jwtService: JwtService

    @Test
    fun voteDiscussionPostWithInvalidId() {
        val authorizationHeader = "Bearer token"
        val user = RegisteredUser(AccountInfo("email","username", "password"),setOf(Authority("ARTIST")))
        whenever(jwtService.getUserFromAuthorizationHeader(authorizationHeader)).thenReturn(user)

        val voteRequest = VoteRequest(-1, 1)
        whenever(discussionPostService.voteDiscussionPost(eq(voteRequest), any())).thenThrow(ResponseStatusException::class.java)
        assertThrows(ResponseStatusException::class.java) { discussionPostController.voteDiscussionPost(voteRequest,authorizationHeader) }
    }

    @Test
    fun voteDiscussionPostWithInvalidVote() {
        val authorizationHeader = "Bearer token"
        val user = RegisteredUser(AccountInfo("email","username", "password"),setOf(Authority("ARTIST")))
        whenever(jwtService.getUserFromAuthorizationHeader(authorizationHeader)).thenReturn(user)
        val voteRequest = VoteRequest(1, 0)
        whenever(discussionPostService.voteDiscussionPost(any(), any())).thenThrow(ResponseStatusException::class.java)
        assertThrows(ResponseStatusException::class.java) { discussionPostController.voteDiscussionPost(voteRequest,authorizationHeader) }
    }
}