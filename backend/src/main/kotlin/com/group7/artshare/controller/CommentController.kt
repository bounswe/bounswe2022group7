package com.group7.artshare.controller

import com.group7.artshare.entity.*
import com.group7.artshare.repository.*
import com.group7.artshare.request.CommentRequest
import com.group7.artshare.service.*
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.repository.findByIdOrNull
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.*
import org.springframework.web.server.ResponseStatusException


@RestController
@CrossOrigin(origins = ["*"], allowedHeaders = ["*"])
@RequestMapping("comment")
class CommentController(
    private val jwtService: JwtService,
    private val commentService: CommentService
) {

    @Autowired
    lateinit var commentRepository: CommentRepository

    @Autowired
    lateinit var registeredUserRepository: RegisteredUserRepository


    @GetMapping("{id}")
    fun getComment(@PathVariable("id") id: Long): Comment =
        commentRepository.findByIdOrNull(id) ?: throw ResponseStatusException(
            HttpStatus.NOT_FOUND,
            "Id is not match with any of the comments in the database"
        )

    @PostMapping(
        consumes = ["application/json;charset=UTF-8"],
        produces = ["application/json;charset=UTF-8"]
    )
    fun create(
        @RequestBody commentRequest: CommentRequest,
        @RequestHeader(
            value = "Authorization",
            required = true
        ) authorizationHeader: String?
    ): Comment {
        try {
            authorizationHeader?.let {
                val user =
                    jwtService.getUserFromAuthorizationHeader(authorizationHeader) ?: throw Exception("Invalid token")
                return commentService.createComment(commentRequest, user)
            } ?: throw Exception("Token required")
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
        @PathVariable id: Long,
        @RequestBody json: Map<String, Long>,
        @RequestHeader(
            value = "Authorization",
            required = true
        ) authorizationHeader: String?
    ){
        try {
            authorizationHeader?.let {
                val user =
                    jwtService.getUserFromAuthorizationHeader(authorizationHeader) ?: throw Exception("Invalid token")
                json["commentedObjectId"]?.let { it1 -> commentService.deleteComment(id, it1, user) }
            } ?: throw Exception("Token required")
        } catch (e: Exception) {
            if (e.message == "Invalid token") {
                throw ResponseStatusException(HttpStatus.UNAUTHORIZED, e.message)
            } else {
                throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
            }
        }
    }
}