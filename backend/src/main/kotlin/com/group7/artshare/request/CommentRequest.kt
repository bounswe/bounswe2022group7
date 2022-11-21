package com.group7.artshare.request

import lombok.Data
import lombok.RequiredArgsConstructor
import javax.validation.constraints.NotEmpty


@Data
@RequiredArgsConstructor
class CommentRequest {

    @NotEmpty
    val text: String? = null

    val commentedObjectId: Long? = null

}