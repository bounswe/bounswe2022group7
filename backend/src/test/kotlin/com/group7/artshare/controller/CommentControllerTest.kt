package com.group7.artshare.controller

import com.group7.artshare.entity.AccountInfo
import com.group7.artshare.entity.Comment
import com.group7.artshare.entity.Image
import com.group7.artshare.entity.RegisteredUser
import com.group7.artshare.request.CommentRequest
import com.group7.artshare.service.CommentService
import com.group7.artshare.service.ImageService
import com.group7.artshare.service.JwtService
import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith
import org.mockito.InjectMocks
import org.mockito.Mock
import org.mockito.Mockito.*
import org.mockito.junit.jupiter.MockitoExtension
import org.springframework.http.HttpStatus
import org.springframework.web.server.ResponseStatusException
import java.util.*


@ExtendWith(MockitoExtension::class)
internal class CommentControllerTest {

    @InjectMocks
    lateinit var commentController: CommentController

    @Mock
    lateinit var commentService: CommentService

    @Mock
    lateinit var jwtService: JwtService

    @Test
    fun failsToCreateIfNotHasAuthorization() {
        val mockCommentRequest = CommentRequest("examplecomment", 1)
        assertThrows(ResponseStatusException::class.java) { commentController.create(mockCommentRequest, "someAuthorization") }
    }

    @Test
    fun failsToDeleteIfNotHasAuthorization() {
        assertThrows(ResponseStatusException::class.java) { commentController.deleteComment(anyLong(), mapOf("commentedObjectId" to anyLong()), "someAuthorization") }

    }

    @Test
    fun successfullyCreatesComment() {
        val mockCommentRequest = CommentRequest("examplecomment", 1)
        val accountInfo1 = AccountInfo("email@email.com", "janedoe", "31415926")
        val mockUser = RegisteredUser(accountInfo1, setOf())
        val mockComment = Comment()
        mockComment.text = mockCommentRequest.text
        `when`(commentService.createComment(mockCommentRequest, mockUser)).thenReturn(mockComment)
        `when`(jwtService.getUserFromAuthorizationHeader("authorizationHeader")).thenReturn(mockUser)
        val response = commentController.create(mockCommentRequest, "authorizationHeader")
        assert(response.text == mockCommentRequest.text)
    }

    @Test
    fun successfullyDeletesComment() {
        val accountInfo1 = AccountInfo("email@email.com", "janedoe", "31415926")
        val mockUser = RegisteredUser(accountInfo1, setOf())
        `when`(jwtService.getUserFromAuthorizationHeader("authorizationHeader")).thenReturn(mockUser)
        val response = commentController.deleteComment(3,  mapOf("commentedObjectId" to 5), "authorizationHeader")
        assert(response == Unit)
    }
}