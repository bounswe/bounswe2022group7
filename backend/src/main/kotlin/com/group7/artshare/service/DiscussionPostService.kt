package com.group7.artshare.service

import com.group7.artshare.entity.*
import com.group7.artshare.repository.*
import com.group7.artshare.request.*
import org.springframework.data.repository.findByIdOrNull
import org.springframework.http.HttpStatus
import org.springframework.security.crypto.password.PasswordEncoder
import org.springframework.stereotype.Service
import org.springframework.web.server.ResponseStatusException

@Service
class DiscussionPostService(
    private val discussionPostRepository: DiscussionPostRepository,
    private val imageRepository: ImageRepository
) {
    fun createDiscussionPost(
        discussionPostRequest: DiscussionPostRequest,
        user: RegisteredUser
    ): DiscussionPost {
        val newDiscussionPost = DiscussionPost()
        newDiscussionPost.creator = user
        if(discussionPostRequest.posterId?.let { imageRepository.existsById(it) } == false)
            throw ResponseStatusException(HttpStatus.BAD_REQUEST, "There is no image in the database with this id")
        newDiscussionPost.posterId = discussionPostRequest.posterId
        newDiscussionPost.title = discussionPostRequest.title
        newDiscussionPost.textBody = discussionPostRequest.textBody
        discussionPostRepository.save(newDiscussionPost)
        return newDiscussionPost
    }

}