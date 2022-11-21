package com.group7.artshare.service

import com.group7.artshare.entity.*
import com.group7.artshare.repository.*
import com.group7.artshare.request.*
import org.springframework.data.repository.findByIdOrNull
import org.springframework.http.HttpStatus
import org.springframework.stereotype.Service
import org.springframework.web.server.ResponseStatusException

@Service
class CommentService(
    private val commentRepository: CommentRepository,
    private val artItemRepository: ArtItemRepository,
    private val discussionPostRepository: DiscussionPostRepository,
    private val onlineGalleryRepository: OnlineGalleryRepository,
    private val physicalExhibitionRepository: PhysicalExhibitionRepository
) {
    fun createComment(
        commentRequest: CommentRequest,
        user: RegisteredUser
    ): Comment {
        val newComment = Comment()
        newComment.author = user

        val commentedObjectId = commentRequest.commentedObjectId
        newComment.text = commentRequest.text
        if (commentedObjectId?.let { artItemRepository.existsById(it) } == true) {
            artItemRepository.findByIdOrNull(commentedObjectId)?.commentList?.add(newComment)
        } else if (commentedObjectId?.let { onlineGalleryRepository.existsById(it) } == true) {
            onlineGalleryRepository.findByIdOrNull(commentedObjectId)?.commentList?.add(newComment)
        } else if (commentedObjectId?.let { physicalExhibitionRepository.existsById(it) } == true) {
            physicalExhibitionRepository.findByIdOrNull(commentedObjectId)?.commentList?.add(newComment)
        } else if (commentedObjectId?.let { discussionPostRepository.existsById(it) } == true) {
            discussionPostRepository.findByIdOrNull(commentedObjectId)?.commentList?.add(newComment)
        } else
            throw ResponseStatusException(
                HttpStatus.BAD_REQUEST,
                "There is no commentable object in the database with this id"
            )
        commentRepository.save(newComment)
        user.commentList.add(newComment)
        return newComment
    }

    fun deleteComment(
        id: Long,
        commentedObjectId: Long,
        user: RegisteredUser
    ) {
        if (!commentRepository.existsById(id)) {
            throw ResponseStatusException(
                HttpStatus.BAD_REQUEST,
                "There is no comment object in the database with this id"
            )
        } else {
            var comment: Comment? = user.commentList.firstOrNull { it.id == id }
                ?: throw ResponseStatusException(
                    HttpStatus.UNAUTHORIZED,
                    "Associated comment is not written by this user"
                )
            user.commentList.remove(comment)
            if (commentedObjectId.let { artItemRepository.existsById(it) }) {
                artItemRepository.findByIdOrNull(commentedObjectId)?.commentList?.remove(comment)
            } else if (commentedObjectId.let { onlineGalleryRepository.existsById(it) }) {
                onlineGalleryRepository.findByIdOrNull(commentedObjectId)?.commentList?.remove(comment)
            } else if (commentedObjectId.let { physicalExhibitionRepository.existsById(it) }) {
                physicalExhibitionRepository.findByIdOrNull(commentedObjectId)?.commentList?.remove(comment)
            } else if (commentedObjectId.let { discussionPostRepository.existsById(it) }) {
                discussionPostRepository.findByIdOrNull(commentedObjectId)?.commentList?.remove(comment)
            } else
                throw ResponseStatusException(
                    HttpStatus.BAD_REQUEST,
                    "Comment is not associated with the given commented object id"
                )
            commentRepository.deleteById(id)
        }
    }
}