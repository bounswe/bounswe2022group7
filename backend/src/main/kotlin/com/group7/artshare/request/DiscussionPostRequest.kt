package com.group7.artshare.request

import lombok.Data
import lombok.RequiredArgsConstructor
import javax.validation.constraints.NotEmpty


@Data
@RequiredArgsConstructor
class DiscussionPostRequest {

    @NotEmpty
    val title: String? = null

    @NotEmpty
    val textBody: String? = null

    val posterId: Long? = null

}