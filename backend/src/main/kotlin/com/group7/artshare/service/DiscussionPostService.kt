package com.group7.artshare.service

import com.group7.artshare.entity.DiscussionPost
import com.group7.artshare.entity.RegisteredUser
import com.group7.artshare.repository.DiscussionPostRepository
import com.group7.artshare.request.DiscussionPostRequest
import org.springframework.data.repository.findByIdOrNull
import org.springframework.http.HttpStatus
import org.springframework.stereotype.Service
import org.springframework.web.server.ResponseStatusException

@Service
class DiscussionPostService(
    private val discussionPostRepository: DiscussionPostRepository
) {
    fun getAllDiscussionPosts(): List<DiscussionPost> = discussionPostRepository.findAll()

    fun getDiscussionPostById(id: Long): DiscussionPost =
        discussionPostRepository.findByIdOrNull(id) ?: throw ResponseStatusException(
            HttpStatus.NOT_FOUND,
            "Id is not matched with any of the discussion posts in the database"
        )

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