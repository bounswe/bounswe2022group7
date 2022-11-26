package com.group7.artshare.controller

import com.group7.artshare.DTO.DiscussionPostDTO
import com.group7.artshare.entity.*
import com.group7.artshare.repository.ArtItemRepository
import com.group7.artshare.repository.DiscussionPostRepository
import com.group7.artshare.repository.OnlineGalleryRepository
import com.group7.artshare.repository.PhysicalExhibitionRepository
import com.group7.artshare.service.JwtService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.*
import org.springframework.web.server.ResponseStatusException


@RestController
@CrossOrigin(origins = ["*"], allowedHeaders = ["*"])
@RequestMapping("discussionForum")
class DiscussionForumController() {

    @Autowired
    lateinit var discussionPostRepository: DiscussionPostRepository

    @GetMapping()
    fun getAllDiscussionPosts(): List<DiscussionPostDTO> {
        return discussionPostRepository.findAll().map { discussionPost -> discussionPost.mapToDTO() }
    }

}