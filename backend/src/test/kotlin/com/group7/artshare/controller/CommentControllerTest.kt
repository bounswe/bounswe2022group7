package com.group7.artshare.controller

import com.group7.artshare.entity.AccountInfo
import com.group7.artshare.entity.Authority
import com.group7.artshare.entity.RegisteredUser
import com.group7.artshare.request.VoteRequest
import com.group7.artshare.service.CommentService
import com.group7.artshare.service.JwtService
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
internal class CommentControllerTest {

    @InjectMocks
    lateinit var commentController: CommentController

    @Mock
    lateinit var commentService: CommentService

    @Mock
    lateinit var jwtService: JwtService

    @Test
    fun voteCommentWithInvalidId() {
        val authorizationHeader = "Bearer token"
        val user = RegisteredUser(AccountInfo("email","username", "password"),setOf(Authority("ARTIST")))
        whenever(jwtService.getUserFromAuthorizationHeader(authorizationHeader)).thenReturn(user)

        val voteRequest = VoteRequest(-1, 1)
        whenever(commentService.voteComment(eq(voteRequest.id), any(),eq(voteRequest.vote))).thenThrow(ResponseStatusException::class.java)
        assertThrows(ResponseStatusException::class.java) { commentController.voteComment(voteRequest,authorizationHeader) }
    }

    @Test
    fun voteCommentWithInvalidVote() {
        val authorizationHeader = "Bearer token"
        val user = RegisteredUser(AccountInfo("email","username", "password"),setOf(Authority("ARTIST")))
        whenever(jwtService.getUserFromAuthorizationHeader(authorizationHeader)).thenReturn(user)
        val voteRequest = VoteRequest(-1, 0)
        whenever(commentService.voteComment(any(), any(),eq(0))).thenThrow(ResponseStatusException::class.java)
        assertThrows(ResponseStatusException::class.java) { commentController.voteComment(voteRequest,authorizationHeader) }
    }

}