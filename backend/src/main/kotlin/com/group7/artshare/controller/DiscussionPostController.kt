package com.group7.artshare.controller

import com.group7.artshare.entity.*
import com.group7.artshare.repository.*
import com.group7.artshare.request.DiscussionPostRequest
import com.group7.artshare.service.*
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.repository.findByIdOrNull
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import org.springframework.web.server.ResponseStatusException


@RestController
@CrossOrigin(origins = ["*"], allowedHeaders = ["*"])
@RequestMapping("discussion")
class DiscussionPostController (
    private val jwtService: JwtService,
    private val discussionPostService: DiscussionPostService
    ) {

    @Autowired
    lateinit var discussionPostRepository: DiscussionPostRepository

    @GetMapping("{id}")
    fun getDiscussionPost(@PathVariable("id") id: Long) : DiscussionPost = discussionPostRepository.findByIdOrNull(id) ?:
        throw ResponseStatusException(HttpStatus.NOT_FOUND, "Id is not match with any of the discussion posts in the database")

    @PostMapping(
        consumes = ["application/json;charset=UTF-8"],
        produces = ["application/json;charset=UTF-8"]
    )
    fun create(
        @RequestBody discussionPostRequest: DiscussionPostRequest,
        @RequestHeader(
            value = "Authorization",
            required = true
        ) authorizationHeader: String?
    ): DiscussionPost {
        try {
            authorizationHeader?.let {
                val user =
                    jwtService.getUserFromAuthorizationHeader(authorizationHeader) ?: throw Exception("Invalid token")
                return discussionPostService.createDiscussionPost(discussionPostRequest, user)
            } ?: throw Exception("Token required")
        } catch (e: Exception) {
            if (e.message == "Invalid token") {
                throw ResponseStatusException(HttpStatus.UNAUTHORIZED, e.message)
            } else {
                throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
            }
        }
    }

//    @DeleteMapping("{id}")
//    @ResponseStatus(HttpStatus.NO_CONTENT)
//    fun delete(
//        @PathVariable id: Long,
//        @RequestHeader(
//            value = "Authorization",
//            required = true
//        ) authorizationHeader: String?
//    ){
//        try {
//            authorizationHeader?.let {
//                val user =
//                    jwtService.getUserFromAuthorizationHeader(authorizationHeader) ?: throw Exception("Invalid token")
//                discussionPostService.deleteDiscussionPost(id, user)
//            } ?: throw Exception("Token required")
//        } catch (e: Exception) {
//            if (e.message == "Invalid token") {
//                throw ResponseStatusException(HttpStatus.UNAUTHORIZED, e.message)
//            } else {
//                throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
//            }
//        }
//    }
}