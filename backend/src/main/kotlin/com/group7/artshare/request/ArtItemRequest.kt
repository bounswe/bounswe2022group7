package com.group7.artshare.request

import com.group7.artshare.entity.ArtItemInfo
import com.group7.artshare.entity.EventInfo
import com.group7.artshare.entity.Location
import lombok.Data
import lombok.Getter
import lombok.RequiredArgsConstructor
import javax.validation.constraints.NotEmpty


@Data
@RequiredArgsConstructor
class ArtItemRequest {
    val creatorId: Long? = null

    @NotEmpty
    val artItemInfo: ArtItemInfo? = null

    val lastPrice: Double? = null

}