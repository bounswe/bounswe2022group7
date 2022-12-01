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
        user.writtenDiscussionPosts.add(newDiscussionPost)
        newDiscussionPost.title = discussionPostRequest.title
        newDiscussionPost.textBody = discussionPostRequest.textBody
        discussionPostRepository.save(newDiscussionPost)
        return newDiscussionPost
    }
//    fun deleteDiscussionPost(
//        id: Long,
//        user: RegisteredUser
//    ) {
//        if (!discussionPostRepository.existsById(id)) {
//            throw ResponseStatusException(
//                HttpStatus.BAD_REQUEST,
//                "There is no discussion post object in the database with this id"
//            )
//        } else {
//            var discussionPost: DiscussionPost? = user.writtenDiscussionPosts.firstOrNull { it.id == id }
//                ?: throw ResponseStatusException(
//                    HttpStatus.UNAUTHORIZED,
//                    "Associated discussion post is not written by this user"
//                )
//            user.writtenDiscussionPosts.remove(discussionPost)
//            discussionPostRepository.deleteById(id)
//        }
//    }


}