package com.group7.artshare.request

import lombok.Data
import lombok.RequiredArgsConstructor
import javax.validation.constraints.NotEmpty

@Data
class CommentVoteRequest(var id: Long, var vote: Int)