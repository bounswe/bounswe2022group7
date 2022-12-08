package com.group7.artshare.request

import lombok.Data
import lombok.RequiredArgsConstructor
import javax.validation.constraints.NotEmpty

@Data
class CommentVoteRequest {
    val id: Long = -1;
    val vote: Int = 0;
}