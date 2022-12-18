package com.group7.artshare.request

import lombok.Data
import lombok.RequiredArgsConstructor


@Data
@RequiredArgsConstructor
class CommentRequest(
    val text: String? = null,

    val commentedObjectId: Long? = null
)