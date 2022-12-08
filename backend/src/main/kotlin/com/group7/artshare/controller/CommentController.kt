package com.group7.artshare.controller

import com.group7.artshare.DTO.CommentDTO
import com.group7.artshare.entity.*
import com.group7.artshare.repository.*
import com.group7.artshare.request.CommentRequest
import com.group7.artshare.request.CommentVoteRequest
import com.group7.artshare.service.*
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.*
import org.springframework.web.server.ResponseStatusException


@RestController
@CrossOrigin(origins = ["*"], allowedHeaders = ["*"])
@RequestMapping("comment")
class CommentController(
    private val jwtService: JwtService, private val commentService: CommentService
) {
    @GetMapping("{id}")
    fun getComment(@PathVariable("id") id: Long): CommentDTO = commentService.getCommentById(id).mapToDTO()

    @PostMapping(
        consumes = ["application/json;charset=UTF-8"], produces = ["application/json;charset=UTF-8"]
    )
    fun create(
        @RequestBody commentRequest: CommentRequest, @RequestHeader(
            value = "Authorization", required = true
        ) authorizationHeader: String
    ): CommentDTO {
        try {
            val user =
                jwtService.getUserFromAuthorizationHeader(authorizationHeader) ?: throw Exception("Invalid token")
            return commentService.createComment(commentRequest, user).mapToDTO()
        } catch (e: Exception) {
            if (e.message == "Invalid token") {
                throw ResponseStatusException(HttpStatus.UNAUTHORIZED, e.message)
            } else {
                throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
            }
        }
    }

    @DeleteMapping("{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    fun deleteComment(
        @PathVariable id: Long, @RequestBody json: Map<String, Long>, @RequestHeader(
            value = "Authorization", required = true
        ) authorizationHeader: String
    ) {
        try {
            val user =
                jwtService.getUserFromAuthorizationHeader(authorizationHeader) ?: throw Exception("Invalid token")
            json["commentedObjectId"]?.let { it1 -> commentService.deleteComment(id, it1, user) }
        } catch (e: Exception) {
            if (e.message == "Invalid token") {
                throw ResponseStatusException(HttpStatus.UNAUTHORIZED, e.message)
            } else {
                throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
            }
        }
    }

    @PostMapping("/vote")
    fun voteComment(
        @RequestBody commentVoteRequest: CommentVoteRequest,
        @RequestHeader(value = "Authorization", required = true) authorizationHeader: String
    ): CommentDTO {
        try {
            val user =
                jwtService.getUserFromAuthorizationHeader(authorizationHeader) ?: throw Exception("Invalid token")
            return commentService.voteComment(commentVoteRequest.id, user, commentVoteRequest.vote)
        } catch (e: Exception) {
            if (e.message == "Invalid token") {
                throw ResponseStatusException(HttpStatus.UNAUTHORIZED, e.message)
            } else {
                throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
            }
        }
    }
}