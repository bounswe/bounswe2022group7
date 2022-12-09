package com.group7.artshare.service

import com.group7.artshare.DTO.CommentDTO
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

    fun getCommentById(id: Long): Comment {
        return commentRepository.findByIdOrNull(id) ?: throw ResponseStatusException(
            HttpStatus.NOT_FOUND, "Comment with id $id not found"
        )
    }
    fun createComment(
        commentRequest: CommentRequest,
        user: RegisteredUser
    ): Comment {
        val newComment = Comment()
        newComment.author = user
        user.commentList.add(newComment)
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

    fun voteComment(
        id: Long,
        user: RegisteredUser,
        vote: Int
    ): CommentDTO {
        val comment = commentRepository.findByIdOrNull(id)?: throw ResponseStatusException(
            HttpStatus.BAD_REQUEST,
            "There is no comment object in the database with this id"
        )
        if(vote == 1){
            comment.downVotedUsers.remove(user)
            comment.upVotedUsers.add(user)
            user.upVotedComments.add(comment)
            user.downVotedComments.remove(comment)
        }
        else if(vote == -1){
            comment.upVotedUsers.remove(user)
            comment.downVotedUsers.add(user)
            user.downVotedComments.add(comment)
            user.upVotedComments.remove(comment)
        }
        else{
            throw ResponseStatusException(
                HttpStatus.BAD_REQUEST,
                "Vote value must be 1 or -1"
            )
        }
        commentRepository.flush()
        return comment.mapToDTO()
    }

}